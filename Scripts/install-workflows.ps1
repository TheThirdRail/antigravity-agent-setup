<#
.SYNOPSIS
    Installs workflows to the selected vendor global workflows folder.
.DESCRIPTION
    Copies all workflow files from Agent/<Vendor>/Workflows to the selected
    vendor global workflows folder so they are available in all projects.
.PARAMETER Vendor
    Which vendor catalog to install from and target globally.
.PARAMETER DryRun
    Preview what would be copied without making changes.
.PARAMETER UseLegacyCodexPath
    For Vendor=openai only, use ~/.codex/workflows instead of ~/.agents/workflows.
.EXAMPLE
    .\install-workflows.ps1
    .\install-workflows.ps1 -Vendor anthropic
    .\install-workflows.ps1 -DryRun
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
        $destPath = "$env:USERPROFILE\.gemini\antigravity\global_workflows"
    }
    'openai' {
        $vendorFolder = 'OpenAI'
        if ($UseLegacyCodexPath) {
            $destPath = "$env:USERPROFILE\.codex\workflows"
        }
        else {
            $destPath = "$env:USERPROFILE\.agents\workflows"
        }
    }
    'anthropic' {
        $vendorFolder = 'Anthropic'
        $destPath = "$env:USERPROFILE\.claude\workflows"
    }
}

$sourcePath = Join-Path $PSScriptRoot "..\Agent\$vendorFolder\Workflows"

Write-Host "=== Workflow Installer ($Vendor) ===" -ForegroundColor Cyan
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
    Write-Host "Done! $($workflows.Count) workflow(s) installed for $Vendor." -ForegroundColor Cyan
}
