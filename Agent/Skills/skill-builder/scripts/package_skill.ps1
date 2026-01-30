<#
.SYNOPSIS
    Validate and package a skill for distribution.

.DESCRIPTION
    Validates the skill structure, frontmatter, and content then creates
    a .skill file (zip archive) for distribution.

.PARAMETER Path
    Path to the skill folder to package.

.PARAMETER OutputDir
    Directory where the .skill file will be created.
    Defaults to current directory.

.PARAMETER SkipValidation
    Skip validation checks (not recommended).

.EXAMPLE
    .\package_skill.ps1 -Path ".agent/skills/pdf-editor" -OutputDir "./dist"
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$Path,

    [Parameter(Mandatory = $false)]
    [string]$OutputDir = ".",

    [Parameter(Mandatory = $false)]
    [switch]$SkipValidation
)

$ErrorActionPreference = "Stop"

# Resolve paths
$SkillPath = Resolve-Path $Path -ErrorAction Stop
$SkillName = Split-Path $SkillPath -Leaf
$SkillMdPath = Join-Path $SkillPath "SKILL.md"

Write-Host "Packaging skill: $SkillName" -ForegroundColor Cyan
Write-Host "Source: $SkillPath" -ForegroundColor Gray

# ============================================================================
# VALIDATION
# ============================================================================

$Errors = @()
$Warnings = @()

if (-not $SkipValidation) {
    Write-Host "`nValidating..." -ForegroundColor Yellow

    # Check SKILL.md exists
    if (-not (Test-Path $SkillMdPath)) {
        $Errors += "SKILL.md not found at: $SkillMdPath"
    }
    else {
        $Content = Get-Content $SkillMdPath -Raw

        # Check YAML frontmatter exists
        if ($Content -notmatch '^---\s*\n([\s\S]*?)\n---') {
            $Errors += "SKILL.md missing YAML frontmatter (must start with ---)"
        }
        else {
            $Frontmatter = $Matches[1]

            # Check required fields
            if ($Frontmatter -notmatch 'name:\s*\S') {
                $Errors += "Frontmatter missing 'name' field"
            }
            else {
                # Extract name and validate
                $FrontmatterName = ($Frontmatter | Select-String -Pattern 'name:\s*(\S+)').Matches.Groups[1].Value
                if ($FrontmatterName -ne $SkillName) {
                    $Warnings += "Frontmatter name '$FrontmatterName' doesn't match folder name '$SkillName'"
                }
            }

            if ($Frontmatter -notmatch 'description:\s*[|\S]') {
                $Errors += "Frontmatter missing 'description' field"
            }
            else {
                # Check description quality
                $DescMatch = $Content | Select-String -Pattern 'description:\s*\|?\s*\n?([\s\S]*?)(?=\n---|\n[a-z]+:)' -AllMatches
                if ($DescMatch) {
                    $Description = $DescMatch.Matches[0].Groups[1].Value.Trim()
                    if ($Description.Length -lt 50) {
                        $Warnings += "Description is very short ($($Description.Length) chars). Include WHEN to use."
                    }
                    if ($Description -match 'TODO') {
                        $Errors += "Description contains TODO placeholder"
                    }
                }
            }
        }

        # Check for TODO placeholders in body
        if ($Content -match '<goal>TODO') {
            $Errors += "Goal section contains TODO placeholder"
        }

        # Check body has XML structure
        if ($Content -notmatch '<skill\s+name=') {
            $Warnings += "SKILL.md body doesn't follow XML structure convention"
        }

        # Check line count
        $LineCount = ($Content -split "`n").Count
        if ($LineCount -gt 500) {
            $Warnings += "SKILL.md is $LineCount lines (recommended: <500). Consider splitting into references/"
        }
    }

    # Check for forbidden files
    $ForbiddenFiles = @("README.md", "CHANGELOG.md", "INSTALLATION_GUIDE.md", "QUICK_REFERENCE.md", "CONTRIBUTING.md")
    foreach ($Forbidden in $ForbiddenFiles) {
        $ForbiddenPath = Join-Path $SkillPath $Forbidden
        if (Test-Path $ForbiddenPath) {
            $Warnings += "Found $Forbidden - skills should only contain AI-facing content"
        }
    }

    # Check naming convention
    if ($SkillName -notmatch '^[a-z][a-z0-9-]*[a-z0-9]$') {
        $Errors += "Skill name must be kebab-case (lowercase letters, numbers, hyphens)"
    }

    if ($SkillName.Length -gt 64) {
        $Errors += "Skill name exceeds 64 characters"
    }

    # Check for deeply nested references
    $DeepFiles = Get-ChildItem -Path $SkillPath -Recurse -File | Where-Object {
        ($_.FullName -replace [regex]::Escape($SkillPath), '').Split([IO.Path]::DirectorySeparatorChar).Count -gt 3
    }
    if ($DeepFiles) {
        $Warnings += "Found deeply nested files (>2 levels). Keep references one level deep."
    }

    # Report validation results
    Write-Host ""
    foreach ($Warn in $Warnings) {
        Write-Host "  [WARN] $Warn" -ForegroundColor Yellow
    }
    foreach ($Err in $Errors) {
        Write-Host "  [ERROR] $Err" -ForegroundColor Red
    }

    if ($Errors.Count -gt 0) {
        Write-Host "`nValidation failed with $($Errors.Count) error(s)." -ForegroundColor Red
        exit 1
    }

    if ($Warnings.Count -eq 0 -and $Errors.Count -eq 0) {
        Write-Host "  All checks passed!" -ForegroundColor Green
    }
}

# ============================================================================
# PACKAGING
# ============================================================================

Write-Host "`nPackaging..." -ForegroundColor Yellow

# Ensure output directory exists
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

$OutputPath = Join-Path (Resolve-Path $OutputDir) "$SkillName.skill"

# Remove existing package if present
if (Test-Path $OutputPath) {
    Remove-Item $OutputPath -Force
}

# Create zip archive (Compress-Archive requires .zip extension)
try {
    $ZipPath = Join-Path (Resolve-Path $OutputDir) "$SkillName.zip"
    
    # Remove existing files if present
    if (Test-Path $ZipPath) { Remove-Item $ZipPath -Force }
    if (Test-Path $OutputPath) { Remove-Item $OutputPath -Force }
    
    # Create zip then rename to .skill
    Compress-Archive -Path "$SkillPath\*" -DestinationPath $ZipPath -Force
    Rename-Item -Path $ZipPath -NewName "$SkillName.skill" -Force
    
    # Get file info
    $FileInfo = Get-Item $OutputPath
    $SizeKB = [math]::Round($FileInfo.Length / 1KB, 2)

    Write-Host "`nPackage created successfully!" -ForegroundColor Green
    Write-Host "  Output: $OutputPath" -ForegroundColor Gray
    Write-Host "  Size: $SizeKB KB" -ForegroundColor Gray

    if ($Warnings.Count -gt 0) {
        Write-Host "`n  Note: Package created with $($Warnings.Count) warning(s). Review above." -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Failed to create package: $_"
    exit 1
}
