param()

$ErrorActionPreference = 'Stop'
$subagentsRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\Subagents') -ErrorAction Stop).Path
$files = Get-ChildItem -Path $subagentsRoot -Filter '*.md' -File | Sort-Object Name
$allowedRoutes = @(
    'analyze',
    'architect',
    'code',
    'dependency-check',
    'deploy',
    'fix-issue',
    'handoff',
    'morning',
    'onboard',
    'performance-tune',
    'pr',
    'project-setup',
    'refactor',
    'research',
    'review',
    'security-audit',
    'test-developer',
    'tutor'
)

function Get-FrontmatterDescription([string]$frontmatter) {
    $lines = $frontmatter -split "`r?`n"
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        if ($line -match '^description:\s*\|\s*$') {
            $parts = @()
            for ($j = $i + 1; $j -lt $lines.Count; $j++) {
                if ($lines[$j] -match '^\s+') { $parts += $lines[$j].Trim() } else { break }
            }
            return (($parts -join ' ') -replace '\s+', ' ').Trim()
        }
        if ($line -match '^description:\s*(.+)$') { return $Matches[1].Trim() }
    }
    return ''
}

$errors = 0
Write-Host '=== Anthropic Subagent Validator ===' -ForegroundColor Cyan
Write-Host "Subagent files found: $($files.Count)" -ForegroundColor Gray
Write-Host ''

foreach ($file in $files) {
    $raw = Get-Content $file.FullName -Raw
    $localErrors = @()

    $fmMatch = [regex]::Match($raw, '(?s)^---\s*\r?\n(.*?)\r?\n---')
    if (-not $fmMatch.Success) {
        $localErrors += 'Missing YAML frontmatter block.'
    }
    else {
        $fm = $fmMatch.Groups[1].Value

        $nameMatch = [regex]::Match($fm, '(?m)^name:\s*([a-z0-9][a-z0-9-]*)\s*$')
        if (-not $nameMatch.Success) {
            $localErrors += 'Missing or invalid name field (kebab-case required).'
        }
        else {
            $name = $nameMatch.Groups[1].Value
            if ($name.Length -gt 64) {
                $localErrors += 'Name exceeds 64 characters.'
            }
            if ($name -ne $file.BaseName) {
                $localErrors += "Name/file mismatch: name='$name' file='$($file.BaseName)'."
            }
        }

        $desc = Get-FrontmatterDescription $fm
        if ([string]::IsNullOrWhiteSpace($desc)) {
            $localErrors += 'Description is empty.'
        }

        $body = $raw.Substring($fmMatch.Length).Trim()
        if ([string]::IsNullOrWhiteSpace($body)) {
            $localErrors += 'Body is empty.'
        }
        else {
            $subagentStart = [regex]::Match($body, '(?s)^<subagent\s+name="([a-z0-9][a-z0-9-]*)"\s+version="[^"]+">')
            if (-not $subagentStart.Success) {
                $localErrors += 'Missing or invalid <subagent name="..." version="..."> root element.'
            }
            else {
                $xmlName = $subagentStart.Groups[1].Value
                if ($nameMatch.Success -and $xmlName -ne $name) {
                    $localErrors += "Frontmatter name ('$name') does not match XML name ('$xmlName')."
                }
            }

            if ($body -notmatch '</subagent>\s*$') {
                $localErrors += 'Missing closing </subagent> tag.'
            }

            $requiredSections = @(
                'purpose',
                'when_to_use',
                'constraints',
                'workflow',
                'output_contract',
                'handoffs'
            )
            foreach ($section in $requiredSections) {
                if ($body -notmatch "(?s)<$section>.*?</$section>") {
                    $localErrors += "Missing required <$section> section."
                }
            }

            $routeMatches = [regex]::Matches($body, '(?s)<route>\s*/([a-z][a-z-]+)\s*</route>')
            if ($routeMatches.Count -eq 0) {
                $localErrors += 'No valid handoff routes found in <handoffs>.'
            }
            else {
                foreach ($routeMatch in $routeMatches) {
                    $route = $routeMatch.Groups[1].Value
                    if ($allowedRoutes -notcontains $route) {
                        $localErrors += "Invalid handoff route '/$route'."
                    }
                }
            }
        }
    }

    if ($localErrors.Count -gt 0) {
        Write-Host "FAIL: $($file.Name)" -ForegroundColor Red
        foreach ($msg in $localErrors) { Write-Host "  - $msg" -ForegroundColor Red }
        $errors += $localErrors.Count
    }
    else {
        Write-Host "PASS: $($file.Name)" -ForegroundColor Green
    }
}

Write-Host ''
if ($errors -gt 0) {
    Write-Host "Validation failed with $errors issue(s)." -ForegroundColor Red
    exit 1
}

Write-Host 'All subagent files passed validation.' -ForegroundColor Cyan
