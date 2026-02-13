[CmdletBinding()]
param(
    [ValidateSet('google', 'openai', 'anthropic', 'all')]
    [string]$Vendor = 'all',
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

function Ensure-Directory {
    param([string]$Path)
    $parent = Split-Path -Parent $Path
    if ($parent -and -not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
}

function Remove-TomlSection {
    param(
        [string[]]$Lines,
        [string]$Header
    )
    $output = New-Object System.Collections.Generic.List[string]
    $skip = $false
    foreach ($line in $Lines) {
        if ($line -match "^\[$([regex]::Escape($Header))\]\s*$") {
            $skip = $true
            continue
        }
        if ($skip -and $line -match '^\[.+\]\s*$') {
            $skip = $false
        }
        if (-not $skip) {
            $output.Add($line)
        }
    }
    return $output
}

function Set-CodexGatewayConfig {
    param(
        [string]$Path,
        [string]$RegistryPath,
        [string]$RuntimeCatalogPath,
        [switch]$DryRunMode
    )

    $content = ''
    if (Test-Path $Path) {
        $content = Get-Content $Path -Raw
    }

    $lines = @()
    if (-not [string]::IsNullOrWhiteSpace($content)) {
        $lines = $content -split "`r?`n"
    }

    $lines = Remove-TomlSection -Lines $lines -Header 'mcp_servers.MCP_DOCKER'

    $hasParentTable = $false
    foreach ($line in $lines) {
        if ($line -match '^\[mcp_servers\]\s*$') {
            $hasParentTable = $true
            break
        }
    }

    $trimmed = New-Object System.Collections.Generic.List[string]
    foreach ($line in $lines) {
        $trimmed.Add($line)
    }

    while ($trimmed.Count -gt 0 -and [string]::IsNullOrWhiteSpace($trimmed[$trimmed.Count - 1])) {
        $trimmed.RemoveAt($trimmed.Count - 1)
    }

    if (-not $hasParentTable) {
        if ($trimmed.Count -gt 0) {
            $trimmed.Add('')
        }
        $trimmed.Add('[mcp_servers]')
    }

    if ($trimmed.Count -gt 0) {
        $trimmed.Add('')
    }
    $trimmed.Add('[mcp_servers.MCP_DOCKER]')
    $trimmed.Add("command = 'docker.exe'")
    $trimmed.Add('args = [')
    $trimmed.Add("    'mcp',")
    $trimmed.Add("    'gateway',")
    $trimmed.Add("    'run',")
    $trimmed.Add("    '--transport',")
    $trimmed.Add("    'stdio',")
    $trimmed.Add("    '--registry',")
    $trimmed.Add("    '$RegistryPath',")
    $trimmed.Add("    '--additional-catalog',")
    $trimmed.Add("    '$RuntimeCatalogPath',")
    $trimmed.Add(']')
    $trimmed.Add('')

    if ($DryRunMode) {
        Write-Host "[DRY RUN] Would update Codex config: $Path" -ForegroundColor Yellow
        return
    }

    Ensure-Directory -Path $Path
    Set-Content -Path $Path -Value ($trimmed -join "`r`n") -Encoding utf8
    Write-Host "Updated Codex config: $Path" -ForegroundColor Green
}

function Read-JsonConfig {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        return @{ mcpServers = @{} }
    }
    $raw = Get-Content $Path -Raw
    if ([string]::IsNullOrWhiteSpace($raw)) {
        return @{ mcpServers = @{} }
    }
    $obj = $raw | ConvertFrom-Json
    return ConvertTo-Hashtable -InputObject $obj
}

function ConvertTo-Hashtable {
    param([Parameter(ValueFromPipeline = $true)]$InputObject)
    if ($null -eq $InputObject) {
        return $null
    }

    if ($InputObject -is [System.Collections.IDictionary]) {
        $hash = @{}
        foreach ($key in $InputObject.Keys) {
            $hash[$key] = ConvertTo-Hashtable -InputObject $InputObject[$key]
        }
        return $hash
    }

    if ($InputObject -is [System.Collections.IEnumerable] -and -not ($InputObject -is [string])) {
        $list = @()
        foreach ($item in $InputObject) {
            $list += ,(ConvertTo-Hashtable -InputObject $item)
        }
        return $list
    }

    if ($InputObject -is [pscustomobject]) {
        $hash = @{}
        foreach ($prop in $InputObject.PSObject.Properties) {
            $hash[$prop.Name] = ConvertTo-Hashtable -InputObject $prop.Value
        }
        return $hash
    }

    return $InputObject
}

function Set-JsonGatewayConfig {
    param(
        [string]$Path,
        [string]$ServerKey,
        [string]$RegistryPath,
        [string]$RuntimeCatalogPath,
        [switch]$DryRunMode
    )

    $config = Read-JsonConfig -Path $Path
    if (-not $config.ContainsKey('mcpServers') -or $null -eq $config.mcpServers) {
        $config['mcpServers'] = @{}
    }

    $existing = $null
    if ($config.mcpServers.ContainsKey($ServerKey)) {
        $existing = $config.mcpServers[$ServerKey]
    }

    $entry = @{
        command = 'docker'
        args    = @(
            'mcp',
            'gateway',
            'run',
            '--transport',
            'stdio',
            '--registry',
            $RegistryPath,
            '--additional-catalog',
            $RuntimeCatalogPath
        )
    }

    if ($existing -is [hashtable] -and $existing.ContainsKey('env') -and $existing.env) {
        $entry['env'] = $existing.env
    }

    $keysToRemove = @()
    foreach ($key in $config.mcpServers.Keys) {
        if ($key -eq $ServerKey) {
            continue
        }
        $candidate = $config.mcpServers[$key]
        if ($candidate -isnot [hashtable]) {
            continue
        }
        if (-not $candidate.ContainsKey('command') -or -not $candidate.ContainsKey('args')) {
            continue
        }
        if ($candidate.command -notin @('docker', 'docker.exe')) {
            continue
        }
        $argsText = ''
        if ($candidate.args -is [array]) {
            $argsText = ($candidate.args -join ' ')
        }
        if (
            $argsText -match '\bmcp\b' -and
            $argsText -match '\bgateway\b' -and
            $argsText -match 'docker-mcp-catalog\.yaml'
        ) {
            $keysToRemove += $key
        }
    }
    foreach ($removeKey in $keysToRemove) {
        $config.mcpServers.Remove($removeKey) | Out-Null
    }

    $config.mcpServers[$ServerKey] = $entry

    if ($DryRunMode) {
        Write-Host "[DRY RUN] Would update JSON config: $Path ($ServerKey)" -ForegroundColor Yellow
        return
    }

    Ensure-Directory -Path $Path
    $config | ConvertTo-Json -Depth 50 | Set-Content -Path $Path -Encoding utf8
    Write-Host "Updated JSON config: $Path ($ServerKey)" -ForegroundColor Green
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$runtimeCatalogPath = (Resolve-Path (Join-Path $repoRoot 'MCP-Servers\mcp-docker-stack\docker-mcp-catalog.runtime.yaml')).Path
$registryPath = (Resolve-Path (Join-Path $repoRoot 'MCP-Servers\mcp-docker-stack\registry.all.yaml')).Path

Write-Host '=== MCP Gateway Client Sync ===' -ForegroundColor Cyan
Write-Host "Runtime catalog: $runtimeCatalogPath" -ForegroundColor Gray
Write-Host "Registry:        $registryPath" -ForegroundColor Gray
Write-Host ''

$targets = @()
switch ($Vendor) {
    'openai' {
        $targets += @{ Type = 'codex'; Path = (Join-Path $env:USERPROFILE '.codex\config.toml') }
    }
    'google' {
        $targets += @{ Type = 'json'; Path = (Join-Path $env:USERPROFILE '.gemini\antigravity\mcp_config.json'); Key = 'MCP_DOCKER' }
    }
    'anthropic' {
        $targets += @{ Type = 'json'; Path = (Join-Path $env:USERPROFILE '.claude.json'); Key = 'MCP_DOCKER' }
    }
    'all' {
        $targets += @{ Type = 'codex'; Path = (Join-Path $env:USERPROFILE '.codex\config.toml') }
        $targets += @{ Type = 'json'; Path = (Join-Path $env:USERPROFILE '.gemini\antigravity\mcp_config.json'); Key = 'MCP_DOCKER' }
        $targets += @{ Type = 'json'; Path = (Join-Path $env:USERPROFILE '.claude.json'); Key = 'MCP_DOCKER' }
    }
}

foreach ($target in $targets) {
    if ($target.Type -eq 'codex') {
        Set-CodexGatewayConfig -Path $target.Path -RegistryPath $registryPath -RuntimeCatalogPath $runtimeCatalogPath -DryRunMode:$DryRun
        continue
    }
    Set-JsonGatewayConfig -Path $target.Path -ServerKey $target.Key -RegistryPath $registryPath -RuntimeCatalogPath $runtimeCatalogPath -DryRunMode:$DryRun
}

if ($DryRun) {
    Write-Host ''
    Write-Host '[DRY RUN] No files were modified.' -ForegroundColor Yellow
}
else {
    Write-Host ''
    Write-Host 'Client gateway configuration sync complete.' -ForegroundColor Cyan
}
