[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [switch]$DryRun,
    [switch]$IncludeLegacyRules
)

$ErrorActionPreference = 'Stop'

$sourceRoot = Join-Path $PSScriptRoot '..\Rules'
$sourceRoot = (Resolve-Path $sourceRoot -ErrorAction Stop).Path
$legacySourceRoot = Join-Path $PSScriptRoot '..\deprecated-Rules'

$sourceClaude = Join-Path $sourceRoot 'CLAUDE.md'
if (-not (Test-Path $sourceClaude)) {
    Write-Host "ERROR: Canonical CLAUDE.md not found: $sourceClaude" -ForegroundColor Red
    exit 1
}

$canonicalRules = @(
    'engineering-quality-rules.md',
    'runtime-safety-rules.md',
    'governance-context-rules.md',
    'routing-tooling-rules.md'
)

$legacyRules = @(
    'code_standards.md',
    'code_style_rules.md',
    'testing_rules.md',
    'documentation_standards.md',
    'environment_rules.md',
    'error_handling_rules.md',
    'logging_standards.md',
    'agent_context_rules.md',
    'archive_rules.md',
    'communication_protocols.md',
    'workflow_router.md',
    'tool_selection_rules.md'
)
$legacyRuleSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$legacyRules)

$rulesToInstall = [System.Collections.Generic.List[string]]::new()
foreach ($rule in $canonicalRules) { $rulesToInstall.Add($rule) }
if ($IncludeLegacyRules) {
    if (-not (Test-Path $legacySourceRoot)) {
        Write-Host "WARNING: Legacy rules source not found: $legacySourceRoot" -ForegroundColor Yellow
    }
    foreach ($rule in $legacyRules) { $rulesToInstall.Add($rule) }
}

$destClaudeRoot = Join-Path $HOME '.claude'
$destClaude = Join-Path $destClaudeRoot 'CLAUDE.md'
$destRulesRoot = Join-Path $destClaudeRoot 'rules'

Write-Host '=== Anthropic Rules Installer ===' -ForegroundColor Cyan
Write-Host "  Source CLAUDE: $sourceClaude" -ForegroundColor Gray
Write-Host "  Dest CLAUDE:   $destClaude" -ForegroundColor Gray
Write-Host "  Dest rules:    $destRulesRoot" -ForegroundColor Gray
Write-Host "  Canonical rules: $($canonicalRules.Count)" -ForegroundColor Gray
if ($IncludeLegacyRules) {
    Write-Host "  Legacy wrappers included: $($legacyRules.Count)" -ForegroundColor Yellow
}
Write-Host ''

if ($DryRun) {
    Write-Host "[DryRun] Would create (if missing): $destClaudeRoot" -ForegroundColor Yellow
    Write-Host "[DryRun] Would create (if missing): $destRulesRoot" -ForegroundColor Yellow
    Write-Host "[DryRun] Would copy: $sourceClaude -> $destClaude" -ForegroundColor Yellow
    foreach ($rule in $rulesToInstall) {
        $srcRoot = if ($legacyRuleSet.Contains($rule)) { $legacySourceRoot } else { $sourceRoot }
        $src = Join-Path $srcRoot $rule
        $dst = Join-Path $destRulesRoot $rule
        Write-Host "[DryRun] Would copy: $src -> $dst" -ForegroundColor Yellow
    }
    Write-Host 'Dry run complete. No files were changed.' -ForegroundColor Yellow
    return
}

if (-not (Test-Path $destClaudeRoot)) {
    if ($PSCmdlet.ShouldProcess($destClaudeRoot, 'Create .claude root directory')) {
        New-Item -ItemType Directory -Path $destClaudeRoot -Force | Out-Null
    }
}

if (-not (Test-Path $destRulesRoot)) {
    if ($PSCmdlet.ShouldProcess($destRulesRoot, 'Create .claude/rules directory')) {
        New-Item -ItemType Directory -Path $destRulesRoot -Force | Out-Null
    }
}

if ($PSCmdlet.ShouldProcess($destClaude, 'Install canonical CLAUDE.md')) {
    Copy-Item -Path $sourceClaude -Destination $destClaude -Force
    Write-Host "Installed: $destClaude" -ForegroundColor Green
}

foreach ($rule in $rulesToInstall) {
    $srcRoot = if ($legacyRuleSet.Contains($rule)) { $legacySourceRoot } else { $sourceRoot }
    $src = Join-Path $srcRoot $rule
    if (-not (Test-Path $src)) {
        Write-Host "SKIP: Source rule missing: $src" -ForegroundColor Red
        continue
    }

    $dst = Join-Path $destRulesRoot $rule
    if ($PSCmdlet.ShouldProcess($dst, 'Install rule file')) {
        Copy-Item -Path $src -Destination $dst -Force
        Write-Host "Installed: $dst" -ForegroundColor Green
    }
}

Write-Host ''
Write-Host 'Done! Anthropic CLAUDE.md and rule files installed.' -ForegroundColor Cyan
