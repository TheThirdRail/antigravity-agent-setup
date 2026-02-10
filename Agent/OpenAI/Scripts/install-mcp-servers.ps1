<#
.SYNOPSIS
    Adds MCP server configurations to OpenAI global MCP configs.
.DESCRIPTION
    Reads docker-mcp-catalog.yaml and adds selected server definitions to one or
    more OpenAI config files (.agents, .codex, and ChatGPT app config).
.PARAMETER DryRun
    Preview what would be changed without writing files.
.PARAMETER ServerNames
    Optional array of specific server names to add. If omitted, script lists available servers.
.PARAMETER IncludeAgents
    Update ~/.agents/mcp_config.json.
.PARAMETER IncludeCodex
    Update ~/.codex/mcp_config.json.
.PARAMETER IncludeChatGPT
    Update %APPDATA%\OpenAI\ChatGPT\mcp_config.json.
#>
param(
    [switch]$DryRun,
    [string[]]$ServerNames,
    [bool]$IncludeAgents = $true,
    [bool]$IncludeCodex = $true,
    [bool]$IncludeChatGPT = $true
)

$ErrorActionPreference = 'Stop'

$catalogPath = Join-Path $PSScriptRoot '..\..\..\MCP-Servers\mcp-docker-stack\docker-mcp-catalog.yaml'

$targetConfigs = @()
if ($IncludeAgents) {
    $targetConfigs += [pscustomobject]@{ Name = 'OpenAI Agents'; Path = (Join-Path $env:USERPROFILE '.agents\mcp_config.json') }
}
if ($IncludeCodex) {
    $targetConfigs += [pscustomobject]@{ Name = 'OpenAI Codex'; Path = (Join-Path $env:USERPROFILE '.codex\mcp_config.json') }
}
if ($IncludeChatGPT) {
    $targetConfigs += [pscustomobject]@{ Name = 'OpenAI ChatGPT'; Path = (Join-Path $env:APPDATA 'OpenAI\ChatGPT\mcp_config.json') }
}

if ($targetConfigs.Count -eq 0) {
    Write-Host 'ERROR: No target config selected. Enable at least one Include* option.' -ForegroundColor Red
    exit 1
}

Write-Host '=== OpenAI MCP Server Installer ===' -ForegroundColor Cyan
Write-Host ''

if (-not (Test-Path $catalogPath)) {
    Write-Host "ERROR: MCP catalog not found: $catalogPath" -ForegroundColor Red
    exit 1
}

$catalogContent = Get-Content $catalogPath -Raw
$serverPattern = '(?m)^([a-zA-Z0-9_-]+):\s*$'
$matches = [regex]::Matches($catalogContent, $serverPattern)
$availableServers = $matches | ForEach-Object { $_.Groups[1].Value }

Write-Host 'Available MCP servers in catalog:' -ForegroundColor White
$availableServers | ForEach-Object { Write-Host "  - $_" -ForegroundColor Gray }
Write-Host ''

Write-Host 'Target config files:' -ForegroundColor White
$targetConfigs | ForEach-Object { Write-Host "  - $($_.Name): $($_.Path)" -ForegroundColor Gray }
Write-Host ''

if (-not $ServerNames -or $ServerNames.Count -eq 0) {
    Write-Host 'To install specific servers, run:' -ForegroundColor Yellow
    Write-Host "  .\install-mcp-servers.ps1 -ServerNames 'server1', 'server2'" -ForegroundColor White
    exit 0
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
        $config = [pscustomobject]@{ mcpServers = [pscustomobject]@{} }
    }

    if (-not $config.mcpServers) {
        $config | Add-Member -NotePropertyName 'mcpServers' -NotePropertyValue ([pscustomobject]@{}) -Force
    }

    return $config
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
    Write-Host 'Done! MCP server entries added for OpenAI targets.' -ForegroundColor Cyan
    Write-Host 'Restart ChatGPT/Codex clients to load the updated MCP config.' -ForegroundColor White
}
