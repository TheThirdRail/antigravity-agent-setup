[CmdletBinding()]
param(
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

Write-Host '=== Deprecation Checker (anthropic) ===' -ForegroundColor Cyan
Write-Host ''

$anthropicRoot = (Resolve-Path (Join-Path $PSScriptRoot '..') -ErrorAction Stop).Path
$sourceRulesRoot = Join-Path $anthropicRoot 'Rules'
$sourceSkillsRoot = Join-Path $anthropicRoot 'Skills'
$sourceWorkflowsRoot = Join-Path $anthropicRoot 'Workflows'
$sourceSubagentsRoot = Join-Path $anthropicRoot 'Subagents'
$sourceClaudePath = Join-Path $sourceRulesRoot 'CLAUDE.md'

$globalClaudeRoot = Join-Path $HOME '.claude'
$globalClaudeFile = Join-Path $globalClaudeRoot 'CLAUDE.md'
$legacyGeminiFile = Join-Path $globalClaudeRoot 'GEMINI.md'
$globalRulesRoot = Join-Path $globalClaudeRoot 'rules'
$globalSkillsRoot = Join-Path $globalClaudeRoot 'skills'
$globalWorkflowsRoot = Join-Path $globalClaudeRoot 'workflows'
$globalSubagentsRoot = Join-Path $globalClaudeRoot 'agents'

$totalRemoved = 0

function Remove-DeprecatedItems {
    param(
        [Parameter(Mandatory = $true)]
        [string]$GlobalPath,
        [Parameter(Mandatory = $false)]
        [string[]]$SourceNames = @(),
        [Parameter(Mandatory = $true)]
        [string]$ItemType,
        [switch]$IsDirectory
    )

    $removed = 0

    if (-not (Test-Path $GlobalPath)) {
        Write-Host "  Global folder not found: $GlobalPath" -ForegroundColor DarkGray
        return 0
    }

    if ($IsDirectory) {
        $globalItems = Get-ChildItem -Path $GlobalPath -Directory -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -notlike '.*' }
    }
    else {
        $globalItems = Get-ChildItem -Path $GlobalPath -Filter '*.md' -File -ErrorAction SilentlyContinue
    }

    foreach ($item in $globalItems) {
        if ($SourceNames -notcontains $item.Name) {
            if ($DryRun) {
                Write-Host "  [WOULD DELETE] $($item.FullName)" -ForegroundColor Yellow
            }
            else {
                if ($IsDirectory) {
                    Remove-Item -Path $item.FullName -Recurse -Force
                }
                else {
                    Remove-Item -Path $item.FullName -Force
                }
                Write-Host "  [DELETED] $($item.FullName)" -ForegroundColor Red
            }
            $removed++
        }
    }

    return $removed
}

Write-Host 'Checking canonical CLAUDE.md...' -ForegroundColor White
if (-not (Test-Path $sourceClaudePath)) {
    if (Test-Path $globalClaudeFile) {
        if ($DryRun) {
            Write-Host "  [WOULD DELETE] $globalClaudeFile (source missing)" -ForegroundColor Yellow
        }
        else {
            Remove-Item -Path $globalClaudeFile -Force
            Write-Host "  [DELETED] $globalClaudeFile (source missing)" -ForegroundColor Red
        }
        $totalRemoved++
    }
}
else {
    Write-Host "  Canonical file managed at: $globalClaudeFile" -ForegroundColor DarkGray
}

if (Test-Path $legacyGeminiFile) {
    if ($DryRun) {
        Write-Host "  [WOULD DELETE] $legacyGeminiFile (legacy compatibility file)" -ForegroundColor Yellow
    }
    else {
        Remove-Item -Path $legacyGeminiFile -Force
        Write-Host "  [DELETED] $legacyGeminiFile (legacy compatibility file)" -ForegroundColor Red
    }
    $totalRemoved++
}

Write-Host 'Checking rules (canonical manifest)...' -ForegroundColor White
$canonicalRuleNames = @(
    'engineering-quality-rules.md',
    'runtime-safety-rules.md',
    'governance-context-rules.md',
    'routing-tooling-rules.md'
)
$count = Remove-DeprecatedItems -GlobalPath $globalRulesRoot -SourceNames $canonicalRuleNames -ItemType 'rules'
if ($count -eq 0) { Write-Host '  Canonical rules are current.' -ForegroundColor Green }
$totalRemoved += $count

Write-Host 'Checking skills...' -ForegroundColor White
$sourceSkillNames = Get-ChildItem -Path $sourceSkillsRoot -Directory -ErrorAction SilentlyContinue |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') } |
    Select-Object -ExpandProperty Name
if (-not $sourceSkillNames) { $sourceSkillNames = @() }
$count = Remove-DeprecatedItems -GlobalPath $globalSkillsRoot -SourceNames $sourceSkillNames -ItemType 'skills' -IsDirectory
if ($count -eq 0) { Write-Host '  All skills are current.' -ForegroundColor Green }
$totalRemoved += $count

Write-Host 'Checking workflows (deprecated compatibility set)...' -ForegroundColor White
$sourceWorkflowNames = Get-ChildItem -Path $sourceWorkflowsRoot -Filter '*.md' -File -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Name
if (-not $sourceWorkflowNames) { $sourceWorkflowNames = @() }
$count = Remove-DeprecatedItems -GlobalPath $globalWorkflowsRoot -SourceNames $sourceWorkflowNames -ItemType 'workflows'
if ($count -eq 0) { Write-Host '  Workflow compatibility files are current.' -ForegroundColor Green }
$totalRemoved += $count

Write-Host 'Checking subagents...' -ForegroundColor White
$sourceSubagentNames = Get-ChildItem -Path $sourceSubagentsRoot -Filter '*.md' -File -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Name
if (-not $sourceSubagentNames) { $sourceSubagentNames = @() }
$count = Remove-DeprecatedItems -GlobalPath $globalSubagentsRoot -SourceNames $sourceSubagentNames -ItemType 'subagents'
if ($count -eq 0) { Write-Host '  All subagents are current.' -ForegroundColor Green }
$totalRemoved += $count

Write-Host ''
if ($DryRun) {
    if ($totalRemoved -gt 0) {
        Write-Host "[DRY RUN] Would remove $totalRemoved deprecated item(s). Remove -DryRun to apply." -ForegroundColor Yellow
    }
    else {
        Write-Host '[DRY RUN] No deprecated items found. Everything is in sync!' -ForegroundColor Green
    }
}
else {
    if ($totalRemoved -gt 0) {
        Write-Host "Removed $totalRemoved deprecated item(s) for anthropic." -ForegroundColor Red
    }
    else {
        Write-Host 'No deprecated items found. Everything is in sync!' -ForegroundColor Green
    }
}
