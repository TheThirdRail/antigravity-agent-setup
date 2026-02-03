<#
.SYNOPSIS
    Move a rule file to the global rules directory (Agent/Rules).
.PARAMETER Name
    Name of the rule file (e.g., rule-name.md)
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Name
)

$ErrorActionPreference = "Stop"

# Paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = $ScriptDir | Split-Path | Split-Path | Split-Path | Split-Path
$Source = Join-Path $Root "Agent\Rules\$Name" # Assuming initially created here or needing verified move
# In this specific context, rules might be created directly in Agent\Rules, 
# but this script formally "installs" or validates them if we were moving from a temp location.
# For simplicity, if it's already in Agent\Rules, we just verify.

$GlobalRulesDir = Join-Path $Root "Agent\Rules"

if (-not (Test-Path $GlobalRulesDir)) {
    New-Item -ItemType Directory -Path $GlobalRulesDir -Force | Out-Null
}

$DestPath = Join-Path $GlobalRulesDir $Name

if (Test-Path $DestPath) {
    Write-Host "Rule '$Name' is installed at: $DestPath" -ForegroundColor Green
}
else {
    Write-Host "Rule '$Name' not found at destination. Please ensure it is created in Agent\Rules." -ForegroundColor Yellow
}
