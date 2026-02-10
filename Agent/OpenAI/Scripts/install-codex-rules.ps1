param(
    [ValidateSet('codex', 'agents', 'both')]
    [string]$Target = 'codex',

    [switch]$MirrorAgents,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

if ($MirrorAgents -and $Target -eq 'codex') {
    $Target = 'both'
}

$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
$sourceRulesFile = Join-Path $projectRoot 'Agent\OpenAI\default.rules'

if (-not (Test-Path $sourceRulesFile)) {
    Write-Host "ERROR: Source rules file not found: $sourceRulesFile" -ForegroundColor Red
    exit 1
}

$targetDirs = @()
if ($Target -in @('codex', 'both')) {
    $targetDirs += (Join-Path $env:USERPROFILE '.codex\rules')
}
if ($Target -in @('agents', 'both')) {
    $targetDirs += (Join-Path $env:USERPROFILE '.agents\rules')
}

foreach ($targetDir in $targetDirs) {
    $dest = Join-Path $targetDir 'default.rules'
    if ($DryRun) {
        Write-Host "[DRY RUN] Would install: $sourceRulesFile -> $dest" -ForegroundColor Yellow
        continue
    }

    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }

    Copy-Item -Path $sourceRulesFile -Destination $dest -Force
    Write-Host "Installed rules: $dest" -ForegroundColor Cyan
}

