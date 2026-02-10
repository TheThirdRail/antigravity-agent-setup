<#
.SYNOPSIS
    Adds MCP server configurations to Antigravity's global MCP config.
.DESCRIPTION
    Reads the docker-mcp-catalog.yaml and adds the server definitions
    to Antigravity's mcp_config.json file.
.PARAMETER DryRun
    Preview what would be added without making changes.
.PARAMETER ServerNames
    Optional array of specific server names to add. If not specified, lists available servers.
.EXAMPLE
    .\install-mcp-servers.ps1
    .\install-mcp-servers.ps1 -DryRun
    .\install-mcp-servers.ps1 -ServerNames "puppeteer", "filesystem"
#>
param(
    [switch]$DryRun,
    [string[]]$ServerNames
)

$ErrorActionPreference = "Stop"

# Paths
$mcpConfigPath = "$env:LOCALAPPDATA\Google\Antigravity\User Data\User\mcp_config.json"
$catalogPath = Join-Path $PSScriptRoot "..\MCP-Servers\mcp-docker-stack\docker-mcp-catalog.yaml"

Write-Host "=== Antigravity MCP Server Installer ===" -ForegroundColor Cyan
Write-Host ""

# Validate catalog exists
if (-not (Test-Path $catalogPath)) {
    Write-Host "ERROR: MCP catalog not found: $catalogPath" -ForegroundColor Red
    exit 1
}

# Read catalog (simple YAML parsing for server names)
$catalogContent = Get-Content $catalogPath -Raw

# Extract server blocks - looking for "server-name:" patterns at root level
$serverPattern = '(?m)^([a-zA-Z0-9_-]+):\s*$'
$matches = [regex]::Matches($catalogContent, $serverPattern)
$availableServers = $matches | ForEach-Object { $_.Groups[1].Value }

Write-Host "Available MCP servers in catalog:" -ForegroundColor White
$availableServers | ForEach-Object { Write-Host "  - $_" -ForegroundColor Gray }
Write-Host ""

# If no specific servers requested, just list and exit
if (-not $ServerNames -or $ServerNames.Count -eq 0) {
    Write-Host "To install specific servers, run:" -ForegroundColor Yellow
    Write-Host "  .\install-mcp-servers.ps1 -ServerNames 'server1', 'server2'" -ForegroundColor White
    Write-Host ""
    Write-Host "Or edit Antigravity's mcp_config.json manually:" -ForegroundColor Yellow
    Write-Host "  $mcpConfigPath" -ForegroundColor White
    exit 0
}

# Ensure mcp_config.json exists
$config = $null
if (-not (Test-Path $mcpConfigPath)) {
    if ($DryRun) {
        Write-Host "[DRY RUN] Would create: $mcpConfigPath" -ForegroundColor Yellow
        $config = [pscustomobject]@{ mcpServers = [pscustomobject]@{} }
    }
    else {
        $initialConfig = @{ mcpServers = @{} }
        $initialConfig | ConvertTo-Json -Depth 10 | Set-Content $mcpConfigPath -Encoding UTF8
        Write-Host "Created: $mcpConfigPath" -ForegroundColor Green
    }
}

# Read existing config when file is present
if (-not $config) {
    $config = Get-Content $mcpConfigPath -Raw | ConvertFrom-Json
}

# Ensure mcpServers property exists
if (-not $config.mcpServers) {
    $config | Add-Member -NotePropertyName "mcpServers" -NotePropertyValue @{} -Force
}

Write-Host "Adding servers to Antigravity config:" -ForegroundColor White
Write-Host ""

foreach ($serverName in $ServerNames) {
    if ($serverName -notin $availableServers) {
        Write-Host "  SKIP: $serverName (not found in catalog)" -ForegroundColor Red
        continue
    }
    
    # Check if already exists
    $exists = $null -ne $config.mcpServers.$serverName
    
    if ($DryRun) {
        $action = if ($exists) { "OVERWRITE" } else { "ADD" }
        Write-Host "  [$action] $serverName" -ForegroundColor Yellow
    }
    else {
        # Create a placeholder entry - user will need to configure
        $config.mcpServers | Add-Member -NotePropertyName $serverName -NotePropertyValue @{
            command = "docker"
            args    = @("run", "--rm", "-i", "mcp/$serverName")
            env     = @{}
        } -Force
        
        $action = if ($exists) { "Updated" } else { "Added" }
        Write-Host "  $action`: $serverName" -ForegroundColor Green
    }
}

# Save config
if (-not $DryRun) {
    $config | ConvertTo-Json -Depth 10 | Set-Content $mcpConfigPath -Encoding UTF8
}

Write-Host ""
if ($DryRun) {
    Write-Host "[DRY RUN] No changes made. Remove -DryRun to install." -ForegroundColor Yellow
}
else {
    Write-Host "Done! MCP server entries added." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "IMPORTANT: You may need to customize the config entries." -ForegroundColor Yellow
    Write-Host "Edit: $mcpConfigPath" -ForegroundColor White
    Write-Host "Restart Antigravity to use the new MCP servers." -ForegroundColor White
}
