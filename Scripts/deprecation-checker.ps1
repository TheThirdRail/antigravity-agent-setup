<#
.SYNOPSIS
    Removes deprecated rules, workflows, and skills from a selected vendor global folders.
.DESCRIPTION
    Compares items in a selected vendor's global folders with this project's
    Agent/<Vendor>/ folder. Deletes global items that no longer exist in the
    project (deprecated), keeping globals in sync.
.PARAMETER Vendor
    Which vendor catalog to compare against.
.PARAMETER DryRun
    Preview what would be deleted without making changes.
.PARAMETER UseLegacyCodexPath
    For Vendor=openai only, use ~/.codex/* instead of ~/.agents/*.
.EXAMPLE
    .\deprecation-checker.ps1
    .\deprecation-checker.ps1 -Vendor anthropic
    .\deprecation-checker.ps1 -DryRun
#>
param(
    [ValidateSet('google', 'openai', 'anthropic')]
    [string]$Vendor = 'google',

    [switch]$DryRun,
    [switch]$UseLegacyCodexPath
)

$ErrorActionPreference = "Stop"

Write-Host "=== Deprecation Checker ($Vendor) ===" -ForegroundColor Cyan
Write-Host ""

# Define paths
$projectRoot = Join-Path $PSScriptRoot ".."

switch ($Vendor) {
    'google' {
        $vendorFolder = 'Google'
        $globalRules = "$env:USERPROFILE\.gemini\rules"
        $globalSkills = "$env:USERPROFILE\.gemini\antigravity\skills"
        $globalWorkflows = "$env:USERPROFILE\.gemini\antigravity\global_workflows"
    }
    'openai' {
        $vendorFolder = 'OpenAI'
        if ($UseLegacyCodexPath) {
            $globalRules = "$env:USERPROFILE\.codex\rules"
            $globalSkills = "$env:USERPROFILE\.codex\skills"
            $globalWorkflows = "$env:USERPROFILE\.codex\workflows"
        }
        else {
            $globalRules = "$env:USERPROFILE\.agents\rules"
            $globalSkills = "$env:USERPROFILE\.agents\skills"
            $globalWorkflows = "$env:USERPROFILE\.agents\workflows"
        }
    }
    'anthropic' {
        $vendorFolder = 'Anthropic'
        $globalRules = "$env:USERPROFILE\.claude\rules"
        $globalSkills = "$env:USERPROFILE\.claude\skills"
        $globalWorkflows = "$env:USERPROFILE\.claude\workflows"
    }
}

# Source paths (this project)
$sourceRules = Join-Path $projectRoot "Agent\$vendorFolder\Rules"
$sourceSkills = Join-Path $projectRoot "Agent\$vendorFolder\Skills"
$sourceWorkflows = Join-Path $projectRoot "Agent\$vendorFolder\Workflows"

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
        $globalItems = Get-ChildItem -Path $GlobalPath -Directory -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -notlike '.*' }
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
        Write-Host "Removed $totalRemoved deprecated item(s) for $Vendor." -ForegroundColor Red
    }
    else {
        Write-Host "No deprecated items found. Everything is in sync!" -ForegroundColor Green
    }
}
