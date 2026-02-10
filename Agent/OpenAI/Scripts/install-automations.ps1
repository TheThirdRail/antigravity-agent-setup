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
$sourceAutomations = Join-Path $projectRoot 'Agent\OpenAI\Automations'

if (-not (Test-Path $sourceAutomations)) {
    Write-Host "ERROR: Automation source folder missing: $sourceAutomations" -ForegroundColor Red
    exit 1
}

$automationFiles = Get-ChildItem -Path $sourceAutomations -File -Filter '*.automation.md' | Sort-Object Name
if ($automationFiles.Count -eq 0) {
    Write-Host "ERROR: No automation templates found under $sourceAutomations" -ForegroundColor Red
    exit 1
}

$targets = @()
if ($Target -in @('codex', 'both')) {
    $targets += (Join-Path $env:USERPROFILE '.codex\automations')
}
if ($Target -in @('agents', 'both')) {
    $targets += (Join-Path $env:USERPROFILE '.agents\automations')
}

Write-Host '=== OpenAI Automations Installer ===' -ForegroundColor Cyan
Write-Host ''

foreach ($destRoot in $targets) {
    if ($DryRun) {
        Write-Host "[DRY RUN] Target automation root: $destRoot" -ForegroundColor Yellow
    }
    elseif (-not (Test-Path $destRoot)) {
        New-Item -ItemType Directory -Path $destRoot -Force | Out-Null
    }

    foreach ($template in $automationFiles) {
        $destFile = Join-Path $destRoot $template.Name
        $exists = Test-Path $destFile
        if ($DryRun) {
            $status = if ($exists) { 'OVERWRITE' } else { 'CREATE' }
            Write-Host "  [DRY RUN][$status] $($template.Name)" -ForegroundColor Yellow
            continue
        }

        Copy-Item -Path $template.FullName -Destination $destFile -Force
        $status = if ($exists) { 'Updated' } else { 'Installed' }
        Write-Host "  $status`: $($template.Name)" -ForegroundColor Green
    }
}

Write-Host ''
if ($DryRun) {
    Write-Host "[DRY RUN] Automation install preview complete. Count: $($automationFiles.Count)" -ForegroundColor Yellow
}
else {
    Write-Host "Installed $($automationFiles.Count) automation templates." -ForegroundColor Green
}
