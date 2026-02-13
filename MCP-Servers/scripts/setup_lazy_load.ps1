[CmdletBinding()]
param(
    [string]$ClientName = 'All Clients',
    [string]$EnvFilePath = '',
    [string]$ReportDirectory = '',
    [switch]$SkipCatalogSync,
    [switch]$SkipSecrets
)

$ErrorActionPreference = 'Stop'

function Get-ServerNamesFromCatalog {
    param([string]$CatalogPath)
    $pattern = '(?m)^  ([a-zA-Z0-9_-]+):\s*$'
    $matches = [regex]::Matches((Get-Content $CatalogPath -Raw), $pattern)
    return @($matches | ForEach-Object { $_.Groups[1].Value })
}

function Write-RegistryFile {
    param(
        [string]$Path,
        [string[]]$ServerNames
    )
    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add('registry:')
    foreach ($name in $ServerNames) {
        $lines.Add("  ${name}:")
        $lines.Add("    ref: ''")
    }
    $parent = Split-Path -Parent $Path
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }
    Set-Content -Path $Path -Value ($lines -join "`r`n") -Encoding utf8
}

function Extract-ErrorLine {
    param([string[]]$Lines)
    foreach ($line in $Lines) {
        if ($line -match '(?i)error|failed|timeout|cannot|unable|EOF|invalid') {
            return $line.Trim()
        }
    }
    if ($Lines.Count -gt 0) {
        return $Lines[0].Trim()
    }
    return ''
}

function Invoke-ServerProbe {
    param(
        [string]$ServerName,
        [string]$RegistryPath,
        [string]$RuntimeCatalogPath
    )

    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $output = docker mcp tools count `
        --gateway-arg="--registry=$RegistryPath" `
        --gateway-arg="--additional-catalog=$RuntimeCatalogPath" `
        --gateway-arg="--servers=$ServerName" 2>&1
    $stopwatch.Stop()

    $lines = @($output | ForEach-Object { "$_" })
    $joined = ($lines -join "`n")
    $toolCount = 0
    $status = 'fail'
    if ($joined -match '\b(\d+)\s+tools?\b') {
        $toolCount = [int]$Matches[1]
        if ($toolCount -gt 0) {
            $status = 'pass'
        }
    }

    return [pscustomobject]@{
        server        = $ServerName
        status        = $status
        tool_count    = $toolCount
        error_excerpt = if ($status -eq 'pass') { '' } else { Extract-ErrorLine -Lines $lines }
        probe_seconds = [Math]::Round($stopwatch.Elapsed.TotalSeconds, 3)
    }
}

function Write-MarkdownReport {
    param(
        [string]$Path,
        [string]$InventoryCatalogPath,
        [string]$RuntimeCatalogPath,
        [string]$RegistryPath,
        [object[]]$Results
    )

    $passCount = @($Results | Where-Object { $_.status -eq 'pass' }).Count
    $failCount = @($Results | Where-Object { $_.status -eq 'fail' }).Count
    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add('# MCP Health Report')
    $lines.Add('')
    $lines.Add("- Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss zzz')")
    $lines.Add("- Inventory catalog: ``$InventoryCatalogPath``")
    $lines.Add("- Runtime catalog: ``$RuntimeCatalogPath``")
    $lines.Add("- Registry: ``$RegistryPath``")
    $lines.Add("- Pass: $passCount")
    $lines.Add("- Fail: $failCount")
    $lines.Add('')
    $lines.Add('| Server | Status | Tool Count | Probe Seconds | Error |')
    $lines.Add('|---|---|---:|---:|---|')
    foreach ($result in $Results) {
        $error = $result.error_excerpt.Replace('|', '\|')
        $lines.Add("| $($result.server) | $($result.status) | $($result.tool_count) | $($result.probe_seconds) | $error |")
    }
    Set-Content -Path $Path -Value ($lines -join "`r`n") -Encoding utf8
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$inventoryCatalogPath = (Resolve-Path (Join-Path $repoRoot 'MCP-Servers\mcp-docker-stack\docker-mcp-catalog.yaml')).Path
$runtimeCatalogPath = (Resolve-Path (Join-Path $repoRoot 'MCP-Servers\mcp-docker-stack\docker-mcp-catalog.runtime.yaml')).Path
$registryPath = Join-Path $repoRoot 'MCP-Servers\mcp-docker-stack\registry.all.yaml'
$secretsScriptPath = Join-Path $PSScriptRoot 'set-mcp-secrets.ps1'
$dockerCustomCatalogPath = Join-Path $env:USERPROFILE '.docker\mcp\catalogs\custom-stack.yaml'

if ([string]::IsNullOrWhiteSpace($ReportDirectory)) {
    $ReportDirectory = Join-Path $repoRoot 'MCP-Servers\reports'
}
if ([string]::IsNullOrWhiteSpace($EnvFilePath)) {
    $EnvFilePath = Join-Path $repoRoot '.env'
}

$overlapServers = @(
    'context7',
    'desktop-commander',
    'fetch',
    'filesystem',
    'firecrawl',
    'github',
    'github-official',
    'gitmcp',
    'memory',
    'notion',
    'obsidian',
    'playwright',
    'semgrep',
    'sentry'
)
$allowedRuntimeOverrides = @('semgrep')

Write-Host '========================================' -ForegroundColor Cyan
Write-Host 'Docker MCP Lazy-Load Setup + Validation' -ForegroundColor Cyan
Write-Host '========================================' -ForegroundColor Cyan
Write-Host "Target client group: $ClientName" -ForegroundColor Gray
Write-Host ''

$inventoryServers = Get-ServerNamesFromCatalog -CatalogPath $inventoryCatalogPath
$runtimeServers = Get-ServerNamesFromCatalog -CatalogPath $runtimeCatalogPath

$invalidOverlap = @(
    $runtimeServers | Where-Object {
        ($_ -in $overlapServers) -and ($_ -notin $allowedRuntimeOverrides)
    }
)
if ($invalidOverlap.Count -gt 0) {
    Write-Error "Runtime catalog includes overlap servers that must stay in the official catalog: $($invalidOverlap -join ', ')"
    exit 1
}

Write-RegistryFile -Path $registryPath -ServerNames $inventoryServers
Write-Host "Generated registry file: $registryPath" -ForegroundColor Green

$registryServers = Get-ServerNamesFromCatalog -CatalogPath $registryPath
$missingFromRegistry = @($inventoryServers | Where-Object { $_ -notin $registryServers })
if ($missingFromRegistry.Count -gt 0) {
    Write-Error "Registry generation failed. Missing servers: $($missingFromRegistry -join ', ')"
    exit 1
}

if (-not $SkipCatalogSync) {
    $dockerCatalogParent = Split-Path -Parent $dockerCustomCatalogPath
    if (-not (Test-Path $dockerCatalogParent)) {
        New-Item -ItemType Directory -Path $dockerCatalogParent -Force | Out-Null
    }
    Copy-Item -Path $runtimeCatalogPath -Destination $dockerCustomCatalogPath -Force
    Write-Host "Synced Docker configured catalog: $dockerCustomCatalogPath" -ForegroundColor Green
}

if (-not $SkipSecrets) {
    if (Test-Path $secretsScriptPath) {
        Write-Host ''
        Write-Host 'Setting MCP secrets from .env...' -ForegroundColor Yellow
        & $secretsScriptPath -EnvFilePath $EnvFilePath
    }
    else {
        Write-Warning "Secrets script not found: $secretsScriptPath"
    }
}

Write-Host ''
Write-Host 'Running isolated server probes...' -ForegroundColor Yellow
$results = @()
foreach ($server in $inventoryServers) {
    Write-Host "  Probing $server ..." -NoNewline
    $result = Invoke-ServerProbe -ServerName $server -RegistryPath $registryPath -RuntimeCatalogPath $runtimeCatalogPath
    $results += $result
    if ($result.status -eq 'pass') {
        Write-Host " PASS ($($result.tool_count) tools, $($result.probe_seconds)s)" -ForegroundColor Green
    }
    else {
        Write-Host " FAIL ($($result.probe_seconds)s)" -ForegroundColor Red
    }
}

if (-not (Test-Path $ReportDirectory)) {
    New-Item -ItemType Directory -Path $ReportDirectory -Force | Out-Null
}
$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$jsonReportPath = Join-Path $ReportDirectory "mcp-health-$timestamp.json"
$mdReportPath = Join-Path $ReportDirectory "mcp-health-$timestamp.md"

$results | ConvertTo-Json -Depth 10 | Set-Content -Path $jsonReportPath -Encoding utf8
Write-MarkdownReport -Path $mdReportPath -InventoryCatalogPath $inventoryCatalogPath -RuntimeCatalogPath $runtimeCatalogPath -RegistryPath $registryPath -Results $results

$passCount = @($results | Where-Object { $_.status -eq 'pass' }).Count
$failCount = @($results | Where-Object { $_.status -eq 'fail' }).Count

Write-Host ''
Write-Host '========================================' -ForegroundColor Cyan
Write-Host "Validation complete: $passCount pass / $failCount fail" -ForegroundColor Cyan
Write-Host "JSON report: $jsonReportPath" -ForegroundColor Gray
Write-Host "MD report:   $mdReportPath" -ForegroundColor Gray
Write-Host '========================================' -ForegroundColor Cyan

if ($failCount -gt 0) {
    exit 1
}
