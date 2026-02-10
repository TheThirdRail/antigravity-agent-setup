param(
    [switch]$DryRun,
    [string[]]$ServerNames
)

$ErrorActionPreference = 'Stop'
$scriptPath = Join-Path $PSScriptRoot '..\..\..\Scripts\install-mcp-servers.ps1'
$params = @{ DryRun = $DryRun }
if ($ServerNames -and $ServerNames.Count -gt 0) {
    $params.ServerNames = $ServerNames
}
& $scriptPath @params
if (-not $?) { exit 1 }
