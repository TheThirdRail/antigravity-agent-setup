<#
.SYNOPSIS
    Installs rules to Antigravity global rules folder.
.DESCRIPTION
    Copies all rule files from Agent/Rules to Antigravity's global
    rules folder so they are available in all projects.
.PARAMETER DryRun
    Preview what would be copied without making changes.
.EXAMPLE
    .\install-rules.ps1
    .\install-rules.ps1 -DryRun
#>
param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# Antigravity global rules location
$destPath = "$env:USERPROFILE\.gemini\rules"
$sourcePath = Join-Path $PSScriptRoot "..\Agent\Rules"

Write-Host "=== Antigravity Rules Installer ===" -ForegroundColor Cyan
Write-Host ""

# Validate source exists
if (-not (Test-Path $sourcePath)) {
    Write-Host "NOTE: Source folder not found: $sourcePath" -ForegroundColor Yellow
    Write-Host "Creating Agent\Rules folder for future use..." -ForegroundColor Yellow
    if (-not $DryRun) {
        New-Item -ItemType Directory -Path $sourcePath -Force | Out-Null
    }
    Write-Host "No rules to install yet. Add .md files to Agent\Rules\" -ForegroundColor White
    exit 0
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

# Get all rule files (markdown files)
$rules = Get-ChildItem -Path $sourcePath -Filter "*.md"

if ($rules.Count -eq 0) {
    Write-Host "No rule files found in $sourcePath" -ForegroundColor Yellow
    exit 0
}

Write-Host "Found $($rules.Count) rule(s) to install:" -ForegroundColor White
Write-Host ""

foreach ($rule in $rules) {
    $destFile = Join-Path $destPath $rule.Name
    $exists = Test-Path $destFile
    
    if ($DryRun) {
        $action = if ($exists) { "OVERWRITE" } else { "CREATE" }
        Write-Host "  [$action] $($rule.Name)" -ForegroundColor Yellow
    }
    else {
        Copy-Item -Path $rule.FullName -Destination $destFile -Force
        $action = if ($exists) { "Updated" } else { "Installed" }
        Write-Host "  $action`: $($rule.Name)" -ForegroundColor Green
    }
}

Write-Host ""
if ($DryRun) {
    Write-Host "[DRY RUN] No changes made. Remove -DryRun to install." -ForegroundColor Yellow
}
else {
    Write-Host "Done! $($rules.Count) rule(s) installed to Antigravity." -ForegroundColor Cyan
    Write-Host "Restart Antigravity to see the new rules." -ForegroundColor White
}
