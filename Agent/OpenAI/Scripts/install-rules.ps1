param(
    [switch]$DryRun,
    [switch]$MirrorAgents,
    [ValidateSet('codex', 'agents', 'both')]
    [string]$Target = 'codex',
    [ValidateSet('global', 'project', 'both')]
    [string]$Scope = 'both',
    [switch]$SkipSkills,
    [switch]$SkipAutomations
)

$ErrorActionPreference = 'Stop'

if ($MirrorAgents -and $Target -eq 'codex') {
    $Target = 'both'
}

Write-Host '=== OpenAI Codex Global Installer ===' -ForegroundColor Cyan
Write-Host ''

$installAgentsScript = Join-Path $PSScriptRoot 'install-agents.ps1'
$installRulesScript = Join-Path $PSScriptRoot 'install-codex-rules.ps1'
$installSkillsScript = Join-Path $PSScriptRoot 'install-skills.ps1'
$installAutomationsScript = Join-Path $PSScriptRoot 'install-automations.ps1'
$installedParts = [System.Collections.Generic.List[string]]::new()

& $installAgentsScript -Target $Target -Scope $Scope -MirrorAgents:$MirrorAgents -DryRun:$DryRun
if (-not $?) { exit 1 }
$installedParts.Add('AGENTS') | Out-Null

if ($Scope -in @('global', 'both')) {
    & $installRulesScript -Target $Target -MirrorAgents:$MirrorAgents -DryRun:$DryRun
    if (-not $?) { exit 1 }
    $installedParts.Add('default.rules') | Out-Null

    if (-not $SkipSkills) {
        & $installSkillsScript -Target $Target -MirrorAgents:$MirrorAgents -DryRun:$DryRun
        if (-not $?) { exit 1 }
        $installedParts.Add('skills') | Out-Null
    }

    if (-not $SkipAutomations) {
        & $installAutomationsScript -Target $Target -MirrorAgents:$MirrorAgents -DryRun:$DryRun
        if (-not $?) { exit 1 }
        $installedParts.Add('automations') | Out-Null
    }
}

Write-Host ''
if ($DryRun) {
    Write-Host '[DRY RUN] OpenAI Codex installation preview complete.' -ForegroundColor Yellow
}
else {
    Write-Host ("Installed: " + ($installedParts -join ', ')) -ForegroundColor Green
}
