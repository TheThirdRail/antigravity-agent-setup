<#
.SYNOPSIS
    Delete a memory from the local SQLite archive.
.PARAMETER Category
    Memory category
.PARAMETER Key
    Key to delete
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Category,
    
    [Parameter(Mandatory = $true)]
    [string]$Key
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

$EscapedKey = $Key -replace "'", "''"
$Sql = "DELETE FROM memories WHERE category='$Category' AND key='$EscapedKey';"
$Sql | sqlite3 $DbPath

Write-Host "✓ Deleted memory: [$Category] $Key" -ForegroundColor Green
