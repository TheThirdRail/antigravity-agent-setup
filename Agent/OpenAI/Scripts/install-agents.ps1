param(
    [ValidateSet('codex', 'agents', 'both')]
    [string]$Target = 'codex',

    [ValidateSet('global', 'project', 'both')]
    [string]$Scope = 'both',

    [switch]$MirrorAgents,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
$sourceAgentsPath = Join-Path $projectRoot 'Agent\OpenAI\AGENTS.md'
$projectAgentsPath = Join-Path $projectRoot 'AGENTS.md'

if ($MirrorAgents -and $Target -eq 'codex') {
    $Target = 'both'
}

if (-not (Test-Path $sourceAgentsPath)) {
    Write-Host "ERROR: Canonical AGENTS source missing: $sourceAgentsPath" -ForegroundColor Red
    exit 1
}

if ($Scope -in @('project', 'both')) {
    if ($DryRun) {
        Write-Host "[DRY RUN] Would sync AGENTS: $sourceAgentsPath -> $projectAgentsPath" -ForegroundColor Yellow
    }
    else {
        Copy-Item -Path $sourceAgentsPath -Destination $projectAgentsPath -Force
        Write-Host "Synced project AGENTS: $projectAgentsPath" -ForegroundColor Green
    }
}

if ($Scope -in @('global', 'both')) {
    $targets = @()
    if ($Target -in @('codex', 'both')) {
        $targets += (Join-Path $env:USERPROFILE '.codex\AGENTS.md')
    }
    if ($Target -in @('agents', 'both')) {
        $targets += (Join-Path $env:USERPROFILE '.agents\AGENTS.md')
    }

    foreach ($dest in $targets) {
        $destDir = Split-Path -Parent $dest
        if ($DryRun) {
            Write-Host "[DRY RUN] Would install AGENTS to: $dest" -ForegroundColor Yellow
            continue
        }

        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }

        Copy-Item -Path $sourceAgentsPath -Destination $dest -Force
        Write-Host "Installed AGENTS: $dest" -ForegroundColor Cyan
    }
}
