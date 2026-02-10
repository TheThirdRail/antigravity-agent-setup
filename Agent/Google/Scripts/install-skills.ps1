[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$sourceRoot = Join-Path $PSScriptRoot '..\Skills'
$sourceRoot = (Resolve-Path $sourceRoot -ErrorAction Stop).Path

$destinationRoot = Join-Path $HOME '.gemini\antigravity\skills'
$skillDirectories = Get-ChildItem -Path $sourceRoot -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }

Write-Host 'Installing Google Antigravity global skills' -ForegroundColor Cyan
Write-Host "  Source root: $sourceRoot" -ForegroundColor Gray
Write-Host "  Destination root: $destinationRoot" -ForegroundColor Gray
Write-Host "  Skills found: $($skillDirectories.Count)" -ForegroundColor Gray

if ($DryRun) {
    foreach ($skillDir in $skillDirectories) {
        $targetPath = Join-Path $destinationRoot $skillDir.Name
        Write-Host "[DryRun] $($skillDir.FullName) -> $targetPath" -ForegroundColor Yellow
    }
    Write-Host 'Dry run complete. No files were changed.' -ForegroundColor Yellow
    return
}

if (-not (Test-Path $destinationRoot)) {
    if ($PSCmdlet.ShouldProcess($destinationRoot, 'Create global skills directory')) {
        New-Item -ItemType Directory -Path $destinationRoot -Force | Out-Null
    }
}

foreach ($skillDir in $skillDirectories) {
    $targetPath = Join-Path $destinationRoot $skillDir.Name

    if (Test-Path $targetPath) {
        if ($PSCmdlet.ShouldProcess($targetPath, 'Remove existing installed skill folder')) {
            Remove-Item -Path $targetPath -Recurse -Force
        }
    }

    if ($PSCmdlet.ShouldProcess($targetPath, 'Copy skill folder')) {
        Copy-Item -Path $skillDir.FullName -Destination $targetPath -Recurse -Force
        Write-Host "Installed: $targetPath" -ForegroundColor Green
    }
}
