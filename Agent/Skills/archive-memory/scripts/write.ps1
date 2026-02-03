<#
.SYNOPSIS
    Write a memory to the local SQLite archive.
.PARAMETER Category
    Memory category (decisions, patterns, files, context, custom)
.PARAMETER Key
    Unique key within the category
.PARAMETER Value
    The content to store
#>
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("decisions", "patterns", "files", "context", "custom")]
    [string]$Category,
    
    [Parameter(Mandatory = $true)]
    [string]$Key,
    
    [Parameter(Mandatory = $true)]
    [string]$Value
)

$ErrorActionPreference = "Stop"

# Locate database
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = $ScriptDir | Split-Path | Split-Path | Split-Path | Split-Path
$DbPath = Join-Path $Root "Agent-Context\Archives\memory.db"

# Ensure directory exists
$DbDir = Split-Path -Parent $DbPath
if (-not (Test-Path $DbDir)) {
    New-Item -ItemType Directory -Path $DbDir -Force | Out-Null
}

# Initialize DB if needed
$InitSql = @"
CREATE TABLE IF NOT EXISTS memories (
    id INTEGER PRIMARY KEY,
    category TEXT NOT NULL,
    key TEXT NOT NULL,
    value TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(category, key)
);
"@

# Use sqlite3 CLI (commonly available)
$InitSql | sqlite3 $DbPath

# Upsert the memory
$EscapedValue = $Value -replace "'", "''"
$EscapedKey = $Key -replace "'", "''"
$UpsertSql = @"
INSERT INTO memories (category, key, value, updated_at)
VALUES ('$Category', '$EscapedKey', '$EscapedValue', datetime('now'))
ON CONFLICT(category, key) DO UPDATE SET
    value = excluded.value,
    updated_at = datetime('now');
"@

$UpsertSql | sqlite3 $DbPath

Write-Host "✓ Stored memory: [$Category] $Key" -ForegroundColor Green
