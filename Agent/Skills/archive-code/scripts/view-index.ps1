<#
.SYNOPSIS
    View contents of a SCIP index file.
.PARAMETER ProjectName
    Name of the project (matches the .scip filename)
.PARAMETER Json
    Output in JSON format
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectName,
    
    [switch]$Json
)

$ErrorActionPreference = "Stop"

# Locate index file
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = $ScriptDir | Split-Path | Split-Path | Split-Path | Split-Path
$IndexFile = Join-Path $Root "Agent-Context\Archives\code-index\$ProjectName.scip"

if (-not (Test-Path $IndexFile)) {
    Write-Host "Error: Index not found: $IndexFile" -ForegroundColor Red
    Write-Host "Available indices:" -ForegroundColor Yellow
    Get-ChildItem (Join-Path $Root "Agent-Context\Archives\code-index") -Filter "*.scip" | ForEach-Object { Write-Host "  - $($_.BaseName)" }
    exit 1
}

# Check for scip CLI
$ScipCli = Get-Command scip -ErrorAction SilentlyContinue
if (-not $ScipCli) {
    Write-Host "Error: scip CLI not found. The index exists but cannot be viewed." -ForegroundColor Yellow
    Write-Host "Index file: $IndexFile" -ForegroundColor Cyan
    $Size = (Get-Item $IndexFile).Length / 1KB
    Write-Host "Size: $([math]::Round($Size, 2)) KB" -ForegroundColor Cyan
    exit 0
}

Write-Host "Viewing index: $IndexFile" -ForegroundColor Cyan

if ($Json) {
    scip print --json $IndexFile
}
else {
    scip print $IndexFile
}
