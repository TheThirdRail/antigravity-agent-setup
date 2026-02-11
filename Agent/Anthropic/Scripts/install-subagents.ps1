[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$sourceRoot = Join-Path $PSScriptRoot '..\Subagents'
$sourceRoot = (Resolve-Path $sourceRoot -ErrorAction Stop).Path
$destinationRoot = Join-Path $HOME '.claude\agents'
$agentFiles = Get-ChildItem -Path $sourceRoot -Filter '*.md' -File | Sort-Object Name

Write-Host '=== Anthropic Subagents Installer ===' -ForegroundColor Cyan
Write-Host "  Source root: $sourceRoot" -ForegroundColor Gray
Write-Host "  Destination root: $destinationRoot" -ForegroundColor Gray
Write-Host "  Subagents found: $($agentFiles.Count)" -ForegroundColor Gray
Write-Host ''

if ($DryRun) {
    foreach ($agent in $agentFiles) {
        $targetPath = Join-Path $destinationRoot $agent.Name
        Write-Host "[DryRun] $($agent.FullName) -> $targetPath" -ForegroundColor Yellow
    }
    Write-Host 'Dry run complete. No files were changed.' -ForegroundColor Yellow
    return
}

if (-not (Test-Path $destinationRoot)) {
    if ($PSCmdlet.ShouldProcess($destinationRoot, 'Create .claude/agents directory')) {
        New-Item -ItemType Directory -Path $destinationRoot -Force | Out-Null
    }
}

foreach ($agent in $agentFiles) {
    $targetPath = Join-Path $destinationRoot $agent.Name
    if ($PSCmdlet.ShouldProcess($targetPath, 'Install subagent file')) {
        Copy-Item -Path $agent.FullName -Destination $targetPath -Force
        Write-Host "Installed: $targetPath" -ForegroundColor Green
    }
}

Write-Host ''
Write-Host 'Done! Anthropic subagents installed.' -ForegroundColor Cyan
