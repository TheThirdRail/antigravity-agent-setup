param(
    [string]$EnvFilePath = (Join-Path $PSScriptRoot '..\..\..\.env')
)

$ErrorActionPreference = 'Stop'
$scriptPath = Join-Path $PSScriptRoot '..\..\..\Scripts\set-mcp-secrets.ps1'
& $scriptPath -EnvFilePath $EnvFilePath
if (-not $?) { exit 1 }
