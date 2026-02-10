param(
    [string]$EnvFilePath = (Join-Path $PSScriptRoot '..\..\..\.env')
)

$ErrorActionPreference = 'Stop'
$scriptPath = Join-Path $PSScriptRoot '..\..\..\Scripts\setup_lazy_load.ps1'
& $scriptPath -ClientName 'Google Antigravity' -EnvFilePath $EnvFilePath
if (-not $?) { exit 1 }
