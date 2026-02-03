<#
.SYNOPSIS
    Removes deprecated rules, workflows, and skills from Antigravity global folders.
.DESCRIPTION
    Compares items in Antigravity's global folders with this project's Agent/ folder.
    Deletes any global items that no longer exist in the project (deprecated).
    This ensures the global folders stay in sync with this project.
.PARAMETER DryRun
    Preview what would be deleted without making changes.
.EXAMPLE
    .\deprecation-checker.ps1
    .\deprecation-checker.ps1 -DryRun
#>
param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

Write-Host "=== Antigravity Deprecation Checker ===" -ForegroundColor Cyan
Write-Host ""

# Define paths
$projectRoot = Join-Path $PSScriptRoot ".."

# Source paths (this project)
$sourceRules = Join-Path $projectRoot "Agent\Rules"
$sourceSkills = Join-Path $projectRoot "Agent\Skills"
$sourceWorkflows = Join-Path $projectRoot "Agent\Workflows"

# Destination paths (Antigravity global)
$globalRules = "$env:USERPROFILE\.gemini\rules"
$globalSkills = "$env:USERPROFILE\.gemini\antigravity\skills"
$globalWorkflows = "$env:USERPROFILE\.gemini\antigravity\global_workflows"

$totalRemoved = 0

# --- Helper function ---
function Remove-DeprecatedItems {
    param(
        [string]$GlobalPath,
        [string]$SourcePath,
        [string]$ItemType,
        [bool]$IsDirectory = $false
    )

    $removed = 0

    if (-not (Test-Path $GlobalPath)) {
        Write-Host "  Global folder not found: $GlobalPath" -ForegroundColor DarkGray
        return 0
    }

    # Get items in global folder
    if ($IsDirectory) {
        $globalItems = Get-ChildItem -Path $GlobalPath -Directory -ErrorAction SilentlyContinue
    }
    else {
        $globalItems = Get-ChildItem -Path $GlobalPath -Filter "*.md" -ErrorAction SilentlyContinue
    }

    if (-not $globalItems -or $globalItems.Count -eq 0) {
        Write-Host "  No $ItemType found in global folder." -ForegroundColor DarkGray
        return 0
    }

    # Get items in source folder
    if ($IsDirectory) {
        $sourceItems = Get-ChildItem -Path $SourcePath -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name
    }
    else {
        $sourceItems = Get-ChildItem -Path $SourcePath -Filter "*.md" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name
    }
    
    if (-not $sourceItems) { $sourceItems = @() }

    foreach ($item in $globalItems) {
        if ($sourceItems -notcontains $item.Name) {
            # Item exists in global but not in source - deprecated
            if ($DryRun) {
                Write-Host "  [WOULD DELETE] $($item.Name)" -ForegroundColor Yellow
            }
            else {
                if ($IsDirectory) {
                    Remove-Item -Path $item.FullName -Recurse -Force
                }
                else {
                    Remove-Item -Path $item.FullName -Force
                }
                Write-Host "  [DELETED] $($item.Name)" -ForegroundColor Red
            }
            $removed++
        }
    }

    return $removed
}

# --- Check Rules ---
Write-Host "Checking Rules..." -ForegroundColor White
$count = Remove-DeprecatedItems -GlobalPath $globalRules -SourcePath $sourceRules -ItemType "rules" -IsDirectory $false
if ($count -eq 0) { Write-Host "  All rules are current." -ForegroundColor Green }
$totalRemoved += $count

# --- Check Skills ---
Write-Host "Checking Skills..." -ForegroundColor White
$count = Remove-DeprecatedItems -GlobalPath $globalSkills -SourcePath $sourceSkills -ItemType "skills" -IsDirectory $true
if ($count -eq 0) { Write-Host "  All skills are current." -ForegroundColor Green }
$totalRemoved += $count

# --- Check Workflows ---
Write-Host "Checking Workflows..." -ForegroundColor White
$count = Remove-DeprecatedItems -GlobalPath $globalWorkflows -SourcePath $sourceWorkflows -ItemType "workflows" -IsDirectory $false
if ($count -eq 0) { Write-Host "  All workflows are current." -ForegroundColor Green }
$totalRemoved += $count

# --- Summary ---
Write-Host ""
if ($DryRun) {
    if ($totalRemoved -gt 0) {
        Write-Host "[DRY RUN] Would remove $totalRemoved deprecated item(s). Remove -DryRun to apply." -ForegroundColor Yellow
    }
    else {
        Write-Host "[DRY RUN] No deprecated items found. Everything is in sync!" -ForegroundColor Green
    }
}
else {
    if ($totalRemoved -gt 0) {
        Write-Host "Removed $totalRemoved deprecated item(s) from Antigravity." -ForegroundColor Red
    }
    else {
        Write-Host "No deprecated items found. Everything is in sync!" -ForegroundColor Green
    }
}
