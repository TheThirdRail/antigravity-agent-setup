[CmdletBinding()]
param(
    [ValidateSet('google', 'openai', 'anthropic')]
    [string]$Vendor,

    [switch]$DryRun,
    [string[]]$ServerNames,

    # OpenAI targets
    [bool]$IncludeAgents = $true,
    [bool]$IncludeCodex = $true,
    [bool]$IncludeChatGPT = $true,

    # Anthropic targets
    [bool]$IncludeClaudeCode = $true,
    [bool]$IncludeClaudeDesktop = $true
)

$ErrorActionPreference = 'Stop'

if (-not $Vendor) {
    Write-Host 'ERROR: -Vendor is required (google|openai|anthropic).' -ForegroundColor Red
    exit 1
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$catalogPath = Join-Path $repoRoot 'MCP-Servers\mcp-docker-stack\docker-mcp-catalog.yaml'

if (-not (Test-Path $catalogPath)) {
    Write-Host "ERROR: MCP catalog not found: $catalogPath" -ForegroundColor Red
    exit 1
}

function New-TargetConfig {
    param(
        [string]$Name,
        [string]$Path
    )

    return [pscustomobject]@{
        Name = $Name
        Path = $Path
    }
}

function Get-TargetConfigs {
    param([string]$VendorName)

    switch ($VendorName) {
        'google' {
            return @(
                (New-TargetConfig -Name 'Google Antigravity' -Path (Join-Path $env:LOCALAPPDATA 'Google\Antigravity\User Data\User\mcp_config.json'))
            )
        }
        'openai' {
            $targets = @()
            if ($IncludeAgents) {
                $targets += New-TargetConfig -Name 'OpenAI Agents' -Path (Join-Path $env:USERPROFILE '.agents\mcp_config.json')
            }
            if ($IncludeCodex) {
                $targets += New-TargetConfig -Name 'OpenAI Codex' -Path (Join-Path $env:USERPROFILE '.codex\mcp_config.json')
            }
            if ($IncludeChatGPT) {
                $targets += New-TargetConfig -Name 'OpenAI ChatGPT' -Path (Join-Path $env:APPDATA 'OpenAI\ChatGPT\mcp_config.json')
            }
            return $targets
        }
        'anthropic' {
            $targets = @()
            if ($IncludeClaudeCode) {
                $targets += New-TargetConfig -Name 'Claude Code' -Path (Join-Path $env:USERPROFILE '.claude.json')
            }
            if ($IncludeClaudeDesktop) {
                $targets += New-TargetConfig -Name 'Claude Desktop' -Path (Join-Path $env:APPDATA 'Claude\claude_desktop_config.json')
            }
            return $targets
        }
        default {
            return @()
        }
    }
}

function Get-McpConfigObject {
    param([string]$ConfigPath)

    $config = $null
    if (Test-Path $ConfigPath) {
        try {
            $config = Get-Content $ConfigPath -Raw | ConvertFrom-Json
        }
        catch {
            Write-Host "ERROR: Invalid JSON in $ConfigPath" -ForegroundColor Red
            throw
        }
    }
    else {
        if ($DryRun) {
            Write-Host "[DRY RUN] Would create: $ConfigPath" -ForegroundColor Yellow
        }
        else {
            $parent = Split-Path -Parent $ConfigPath
            if ($parent -and -not (Test-Path $parent)) {
                New-Item -ItemType Directory -Path $parent -Force | Out-Null
            }
        }

        $config = [pscustomobject]@{
            mcpServers = [pscustomobject]@{}
        }
    }

    if (-not $config.mcpServers) {
        $config | Add-Member -NotePropertyName 'mcpServers' -NotePropertyValue ([pscustomobject]@{}) -Force
    }

    return $config
}

$targetConfigs = Get-TargetConfigs -VendorName $Vendor
if ($targetConfigs.Count -eq 0) {
    Write-Host "ERROR: No target config selected for vendor '$Vendor'." -ForegroundColor Red
    exit 1
}

$catalogContent = Get-Content $catalogPath -Raw
$serverPattern = '(?m)^  ([a-zA-Z0-9_-]+):\s*$'
$matches = [regex]::Matches($catalogContent, $serverPattern)
$availableServers = $matches | ForEach-Object { $_.Groups[1].Value }

Write-Host "=== MCP Server Installer ($Vendor) ===" -ForegroundColor Cyan
Write-Host ''
Write-Host "Catalog: $catalogPath" -ForegroundColor Gray
Write-Host 'Available MCP servers in catalog:' -ForegroundColor White
$availableServers | ForEach-Object { Write-Host "  - $_" -ForegroundColor Gray }
Write-Host ''
Write-Host 'Target config files:' -ForegroundColor White
$targetConfigs | ForEach-Object { Write-Host "  - $($_.Name): $($_.Path)" -ForegroundColor Gray }
Write-Host ''

if (-not $ServerNames -or $ServerNames.Count -eq 0) {
    Write-Host 'To install specific servers, run:' -ForegroundColor Yellow
    Write-Host "  .\install-mcp-servers.ps1 -Vendor $Vendor -ServerNames 'server1', 'server2'" -ForegroundColor White
    exit 0
}

foreach ($target in $targetConfigs) {
    Write-Host "Updating $($target.Name)..." -ForegroundColor White
    $config = Get-McpConfigObject -ConfigPath $target.Path

    foreach ($serverName in $ServerNames) {
        if ($serverName -notin $availableServers) {
            Write-Host "  SKIP: $serverName (not found in catalog)" -ForegroundColor Red
            continue
        }

        $exists = $null -ne $config.mcpServers.PSObject.Properties[$serverName]
        if ($DryRun) {
            $action = if ($exists) { 'OVERWRITE' } else { 'ADD' }
            Write-Host "  [$action] $serverName" -ForegroundColor Yellow
            continue
        }

        $config.mcpServers | Add-Member -NotePropertyName $serverName -NotePropertyValue @{
            command = 'docker'
            args    = @('run', '--rm', '-i', "mcp/$serverName")
            env     = @{}
        } -Force

        $action = if ($exists) { 'Updated' } else { 'Added' }
        Write-Host "  $action`: $serverName" -ForegroundColor Green
    }

    if (-not $DryRun) {
        $config | ConvertTo-Json -Depth 20 | Set-Content $target.Path -Encoding UTF8
    }

    Write-Host ''
}

if ($DryRun) {
    Write-Host '[DRY RUN] No changes made. Remove -DryRun to install.' -ForegroundColor Yellow
}
else {
    Write-Host "Done! MCP server entries added for vendor '$Vendor'." -ForegroundColor Cyan
}
