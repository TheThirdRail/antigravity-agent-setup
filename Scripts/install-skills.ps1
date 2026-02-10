<#
.SYNOPSIS
    Installs skills to the selected vendor global skills folder.
.DESCRIPTION
    Copies all skill folders from Agent/<Vendor>/Skills to the selected
    vendor's global skills folder so they are available in all projects.
.PARAMETER Vendor
    Which vendor catalog to install from and target globally.
.PARAMETER DryRun
    Preview what would be copied without making changes.
.PARAMETER UseLegacyCodexPath
    For Vendor=openai only, use ~/.codex/skills instead of ~/.agents/skills.
.EXAMPLE
    .\install-skills.ps1
    .\install-skills.ps1 -Vendor openai
    .\install-skills.ps1 -DryRun
#>
param(
    [ValidateSet('google', 'openai', 'anthropic')]
    [string]$Vendor = 'google',

    [switch]$DryRun,
    [switch]$UseLegacyCodexPath
)

$ErrorActionPreference = "Stop"

switch ($Vendor) {
    'google' {
        $vendorFolder = 'Google'
        $destPath = "$env:USERPROFILE\.gemini\antigravity\skills"
    }
    'openai' {
        $vendorFolder = 'OpenAI'
        if ($UseLegacyCodexPath) {
            $destPath = "$env:USERPROFILE\.codex\skills"
        }
        else {
            $destPath = "$env:USERPROFILE\.agents\skills"
        }
    }
    'anthropic' {
        $vendorFolder = 'Anthropic'
        $destPath = "$env:USERPROFILE\.claude\skills"
    }
}

$sourcePath = Join-Path $PSScriptRoot "..\Agent\$vendorFolder\Skills"

Write-Host "=== Skills Installer ($Vendor) ===" -ForegroundColor Cyan
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

# Get all skill folders (each skill is a folder containing SKILL.md)
$skills = Get-ChildItem -Path $sourcePath -Directory

if ($skills.Count -eq 0) {
    Write-Host "No skill folders found in $sourcePath" -ForegroundColor Yellow
    exit 0
}

Write-Host "Found $($skills.Count) skill(s) to install:" -ForegroundColor White
Write-Host ""

foreach ($skill in $skills) {
    $destFolder = Join-Path $destPath $skill.Name
    $exists = Test-Path $destFolder
    
    if ($DryRun) {
        $action = if ($exists) { "OVERWRITE" } else { "CREATE" }
        Write-Host "  [$action] $($skill.Name)/" -ForegroundColor Yellow
    }
    else {
        # Remove existing folder if it exists
        if ($exists) {
            Remove-Item -Path $destFolder -Recurse -Force
        }
        # Copy entire skill folder
        Copy-Item -Path $skill.FullName -Destination $destFolder -Recurse -Force
        $action = if ($exists) { "Updated" } else { "Installed" }
        Write-Host "  $action`: $($skill.Name)/" -ForegroundColor Green
    }
}

Write-Host ""
if ($DryRun) {
    Write-Host "[DRY RUN] No changes made. Remove -DryRun to install." -ForegroundColor Yellow
}
else {
    Write-Host "Done! $($skills.Count) skill(s) installed for $Vendor." -ForegroundColor Cyan
}
