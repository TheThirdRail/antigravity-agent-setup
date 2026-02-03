<#
.SYNOPSIS
    Read memories from the local SQLite archive.
.PARAMETER Category
    Memory category to filter by
.PARAMETER Key
    Specific key to retrieve
.PARAMETER Search
    Search term to find across all memories
#>
param(
    [string]$Category,
    [string]$Key,
    [string]$Search
)

$ErrorActionPreference = "Stop"

# Locate database
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = $ScriptDir | Split-Path | Split-Path | Split-Path | Split-Path
$DbPath = Join-Path $Root "Agent-Context\Archives\memory.db"

if (-not (Test-Path $DbPath)) {
    Write-Host "No memories found. Archive not initialized." -ForegroundColor Yellow
    exit 0
}

# Build query
if ($Key -and $Category) {
    $Sql = "SELECT value FROM memories WHERE category='$Category' AND key='$Key';"
    $Result = $Sql | sqlite3 $DbPath
    if ($Result) {
        Write-Output $Result
    }
    else {
        Write-Host "Memory not found: [$Category] $Key" -ForegroundColor Yellow
    }
}
elseif ($Category) {
    $Sql = "SELECT key, value FROM memories WHERE category='$Category' ORDER BY updated_at DESC;"
    $Result = $Sql | sqlite3 -header -column $DbPath
    if ($Result) {
        Write-Output $Result
    }
    else {
        Write-Host "No memories in category: $Category" -ForegroundColor Yellow
    }
}
elseif ($Search) {
    $EscapedSearch = $Search -replace "'", "''"
    $Sql = "SELECT category, key, value FROM memories WHERE value LIKE '%$EscapedSearch%' OR key LIKE '%$EscapedSearch%' ORDER BY updated_at DESC;"
    $Result = $Sql | sqlite3 -header -column $DbPath
    if ($Result) {
        Write-Output $Result
    }
    else {
        Write-Host "No memories matching: $Search" -ForegroundColor Yellow
    }
}
else {
    # List all categories with counts
    $Sql = "SELECT category, COUNT(*) as count FROM memories GROUP BY category;"
    $Result = $Sql | sqlite3 -header -column $DbPath
    Write-Host "Memory Archive Summary:" -ForegroundColor Cyan
    Write-Output $Result
}
