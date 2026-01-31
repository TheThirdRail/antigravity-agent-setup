<#
.SYNOPSIS
    Installs workflows to Antigravity global workflows folder.
.DESCRIPTION
    Copies all workflow files from Agent/Workflows to Antigravity's global
    workflows folder so they are available in all projects.
.PARAMETER DryRun
    Preview what would be copied without making changes.
.EXAMPLE
    .\install-workflows.ps1
    .\install-workflows.ps1 -DryRun
#>
param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# Antigravity global workflows location
$destPath = "$env:USERPROFILE\.gemini\antigravity\global_workflows"
$sourcePath = Join-Path $PSScriptRoot "..\Agent\Workflows"

Write-Host "=== Antigravity Workflow Installer ===" -ForegroundColor Cyan
Write-Host ""

# Validate source exists
if (-not (Test-Path $sourcePath)) {
    Write-Host "ERROR: Source folder not found: $sourcePath" -ForegroundColor Red
    exit 1
}

# Create destination if it doesn't exist
if (-not (Test-Path $destPath)) {
    if ($DryRun) {
        Write-Host "[DRY RUN] Would create directory: $destPath" -ForegroundColor Yellow
    }
    else {
        New-Item -ItemType Directory -Path $destPath -Force | Out-Null
        Write-Host "Created directory: $destPath" -ForegroundColor Green
    }
}

# Get all workflow files
$workflows = Get-ChildItem -Path $sourcePath -Filter "*.md"

if ($workflows.Count -eq 0) {
    Write-Host "No workflow files found in $sourcePath" -ForegroundColor Yellow
    exit 0
}

Write-Host "Found $($workflows.Count) workflow(s) to install:" -ForegroundColor White
Write-Host ""

foreach ($workflow in $workflows) {
    $destFile = Join-Path $destPath $workflow.Name
    $exists = Test-Path $destFile
    
    if ($DryRun) {
        $action = if ($exists) { "OVERWRITE" } else { "CREATE" }
        Write-Host "  [$action] $($workflow.Name)" -ForegroundColor Yellow
    }
    else {
        Copy-Item -Path $workflow.FullName -Destination $destFile -Force
        $action = if ($exists) { "Updated" } else { "Installed" }
        Write-Host "  $action`: $($workflow.Name)" -ForegroundColor Green
    }
}

Write-Host ""
if ($DryRun) {
    Write-Host "[DRY RUN] No changes made. Remove -DryRun to install." -ForegroundColor Yellow
}
else {
    Write-Host "Done! $($workflows.Count) workflow(s) installed to Antigravity." -ForegroundColor Cyan
    Write-Host "Restart Antigravity to see the new workflows." -ForegroundColor White
}
