param(
    [Parameter(Mandatory = $true)]
    [string]$Name
)

$SourcePath = Join-Path (Get-Location) $Name
$LocalPath = ".agent\workflows"

if (-not (Test-Path $LocalPath)) {
    New-Item -ItemType Directory -Path $LocalPath -Force | Out-Null
}

$DestPath = Join-Path $LocalPath $Name

if (Test-Path $SourcePath) {
    Move-Item -Path $SourcePath -Destination $DestPath -Force
    Write-Host "Workflow moved to Local: $DestPath" -ForegroundColor Green
}
else {
    Write-Error "Source path not found: $SourcePath"
}
