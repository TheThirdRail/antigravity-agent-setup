param(
    [Parameter(Mandatory = $true)]
    [string]$Name
)

$SourcePath = Join-Path (Get-Location) $Name
$GlobalPath = "$HOME\.gemini\antigravity\global_workflows"

if (-not (Test-Path $GlobalPath)) {
    New-Item -ItemType Directory -Path $GlobalPath -Force | Out-Null
}

$DestPath = Join-Path $GlobalPath $Name

if (Test-Path $SourcePath) {
    Move-Item -Path $SourcePath -Destination $DestPath -Force
    Write-Host "Workflow moved to Global: $DestPath" -ForegroundColor Green
}
else {
    Write-Error "Source path not found: $SourcePath"
}
