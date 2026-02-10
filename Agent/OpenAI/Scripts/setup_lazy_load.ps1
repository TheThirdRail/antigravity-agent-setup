param(
    [string]$EnvFilePath = (Join-Path $PSScriptRoot '..\..\..\.env')
)

$ErrorActionPreference = 'Stop'
$scriptPath = Join-Path $PSScriptRoot '..\..\..\Scripts\setup_lazy_load.ps1'
& $scriptPath -ClientName 'OpenAI ChatGPT/Codex' -EnvFilePath $EnvFilePath
if (-not $?) { exit 1 }
