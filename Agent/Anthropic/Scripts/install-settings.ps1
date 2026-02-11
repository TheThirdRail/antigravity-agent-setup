[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$sourcePath = Join-Path $PSScriptRoot '..\Settings\settings.global.json'
$sourcePath = (Resolve-Path $sourcePath -ErrorAction Stop).Path
$targetPath = Join-Path $HOME '.claude\settings.json'

function ConvertTo-Hashtable {
    param([Parameter(ValueFromPipeline = $true)]$InputObject)

    if ($null -eq $InputObject) { return $null }
    if (($InputObject -is [System.ValueType]) -or ($InputObject -is [string])) { return $InputObject }

    if ($InputObject -is [System.Collections.IDictionary]) {
        $hash = @{}
        foreach ($key in $InputObject.Keys) {
            $hash[$key] = ConvertTo-Hashtable $InputObject[$key]
        }
        return $hash
    }

    if ($InputObject -is [System.Collections.IEnumerable] -and -not ($InputObject -is [string])) {
        $list = @()
        foreach ($item in $InputObject) {
            $list += ,(ConvertTo-Hashtable $item)
        }
        return $list
    }

    if ($InputObject.PSObject -and $InputObject.PSObject.Properties.Count -gt 0) {
        $hash = @{}
        foreach ($prop in $InputObject.PSObject.Properties) {
            $hash[$prop.Name] = ConvertTo-Hashtable $prop.Value
        }
        return $hash
    }

    return $InputObject
}

function Merge-Settings {
    param(
        [hashtable]$Base,
        [hashtable]$Overlay
    )

    foreach ($key in $Overlay.Keys) {
        if (-not $Base.ContainsKey($key)) {
            $Base[$key] = $Overlay[$key]
            continue
        }

        $baseVal = $Base[$key]
        $overlayVal = $Overlay[$key]

        if ($baseVal -is [hashtable] -and $overlayVal -is [hashtable]) {
            Merge-Settings -Base $baseVal -Overlay $overlayVal
            continue
        }

        if (($baseVal -is [System.Array]) -and ($overlayVal -is [System.Array])) {
            if ($key -eq 'ask') {
                $set = [System.Collections.Generic.List[object]]::new()
                foreach ($entry in $baseVal) {
                    if ($set -notcontains $entry) { $set.Add($entry) }
                }
                foreach ($entry in $overlayVal) {
                    if ($set -notcontains $entry) { $set.Add($entry) }
                }
                $Base[$key] = $set.ToArray()
            }
            else {
                $Base[$key] = $overlayVal
            }
            continue
        }

        $Base[$key] = $overlayVal
    }
}

$baseline = Get-Content $sourcePath -Raw | ConvertFrom-Json
$baselineHash = ConvertTo-Hashtable $baseline

$currentHash = @{}
if (Test-Path $targetPath) {
    $existing = Get-Content $targetPath -Raw | ConvertFrom-Json
    $currentHash = ConvertTo-Hashtable $existing
}

if (-not (Test-Path (Split-Path -Parent $targetPath))) {
    if (-not $DryRun) {
        New-Item -ItemType Directory -Path (Split-Path -Parent $targetPath) -Force | Out-Null
    }
}

Merge-Settings -Base $currentHash -Overlay $baselineHash
$mergedJson = ($currentHash | ConvertTo-Json -Depth 32)

Write-Host '=== Anthropic Settings Installer ===' -ForegroundColor Cyan
Write-Host "  Baseline: $sourcePath" -ForegroundColor Gray
Write-Host "  Target:   $targetPath" -ForegroundColor Gray
Write-Host ''

if ($DryRun) {
    Write-Host '[DryRun] Would merge baseline into target settings.' -ForegroundColor Yellow
    Write-Host 'Preview (first 40 lines):' -ForegroundColor Yellow
    ($mergedJson -split "`r?`n") | Select-Object -First 40 | ForEach-Object { Write-Host $_ -ForegroundColor DarkGray }
    Write-Host 'Dry run complete. No files were changed.' -ForegroundColor Yellow
    return
}

if ($PSCmdlet.ShouldProcess($targetPath, 'Write merged Claude settings')) {
    Set-Content -Path $targetPath -Value $mergedJson -Encoding UTF8
    Write-Host "Installed merged settings: $targetPath" -ForegroundColor Green
}
