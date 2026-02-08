<#
.SYNOPSIS
    View contents of a SCIP index file.
.PARAMETER ProjectName
    Name of the project (matches the .scip filename)
.PARAMETER ProjectPath
    Path to the project root that contains Agent-Context/Archives/code-index
.PARAMETER Json
    Output in JSON format
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectName,

    [Parameter(Mandatory = $false)]
    [string]$ProjectPath = ".",
    
    [switch]$Json
)

$ErrorActionPreference = "Stop"

$ResolvedProjectPath = (Resolve-Path $ProjectPath -ErrorAction Stop).Path
$IndexDir = Join-Path $ResolvedProjectPath "Agent-Context\Archives\code-index"
$IndexFile = Join-Path $IndexDir "$ProjectName.scip"

if (-not (Test-Path $IndexFile)) {
    Write-Host "Error: Index not found: $IndexFile" -ForegroundColor Red
    Write-Host "Available indices:" -ForegroundColor Yellow
    if (Test-Path $IndexDir) {
        Get-ChildItem $IndexDir -Filter "*.scip" | ForEach-Object { Write-Host "  - $($_.BaseName)" }
    }
    else {
        Write-Host "  (none found at $IndexDir)" -ForegroundColor Yellow
    }
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
