param(
    [int]$MaxChars = 12000
)

$ErrorActionPreference = 'Stop'
$rulesRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\Rules') -ErrorAction Stop).Path

$activeRules = @(
    'CLAUDE.md',
    'engineering-quality-rules.md',
    'runtime-safety-rules.md',
    'governance-context-rules.md',
    'routing-tooling-rules.md'
)

$violations = 0
Write-Host '=== Anthropic Rule Length Validator ===' -ForegroundColor Cyan
Write-Host "Max chars per active rule file: $MaxChars" -ForegroundColor Gray
Write-Host ''

foreach ($fileName in $activeRules) {
    $path = Join-Path $rulesRoot $fileName
    if (-not (Test-Path $path)) {
        Write-Host "MISSING: $fileName" -ForegroundColor Red
        $violations++
        continue
    }

    $length = (Get-Content $path -Raw).Length
    if ($length -gt $MaxChars) {
        Write-Host "FAIL: $fileName = $length chars (limit: $MaxChars)" -ForegroundColor Red
        $violations++
    }
    else {
        Write-Host "PASS: $fileName = $length chars" -ForegroundColor Green
    }
}

Write-Host ''
if ($violations -gt 0) {
    Write-Host "Validation failed with $violations violation(s)." -ForegroundColor Red
    exit 1
}

Write-Host 'All active rule files are within character limit.' -ForegroundColor Cyan
