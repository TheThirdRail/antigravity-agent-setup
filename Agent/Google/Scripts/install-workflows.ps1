[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$sourceRoot = Join-Path $PSScriptRoot '..\Workflows'
$sourceRoot = (Resolve-Path $sourceRoot -ErrorAction Stop).Path

$destinationRoot = Join-Path $HOME '.gemini\antigravity\global_workflows'
$workflowFiles = Get-ChildItem -Path $sourceRoot -Filter '*.md' -File

Write-Host 'Installing Google Antigravity global workflows' -ForegroundColor Cyan
Write-Host "  Source root: $sourceRoot" -ForegroundColor Gray
Write-Host "  Destination root: $destinationRoot" -ForegroundColor Gray
Write-Host "  Workflows found: $($workflowFiles.Count)" -ForegroundColor Gray

if ($DryRun) {
    foreach ($workflowFile in $workflowFiles) {
        $targetPath = Join-Path $destinationRoot $workflowFile.Name
        Write-Host "[DryRun] $($workflowFile.FullName) -> $targetPath" -ForegroundColor Yellow
    }
    Write-Host 'Dry run complete. No files were changed.' -ForegroundColor Yellow
    return
}

if (-not (Test-Path $destinationRoot)) {
    if ($PSCmdlet.ShouldProcess($destinationRoot, 'Create global workflows directory')) {
        New-Item -ItemType Directory -Path $destinationRoot -Force | Out-Null
    }
}

foreach ($workflowFile in $workflowFiles) {
    $targetPath = Join-Path $destinationRoot $workflowFile.Name

    if (Test-Path $targetPath) {
        if ($PSCmdlet.ShouldProcess($targetPath, 'Remove existing installed workflow file')) {
            Remove-Item -Path $targetPath -Force
        }
    }

    if ($PSCmdlet.ShouldProcess($targetPath, 'Copy workflow file')) {
        Copy-Item -Path $workflowFile.FullName -Destination $targetPath -Force
        Write-Host "Installed: $targetPath" -ForegroundColor Green
    }
}
