[CmdletBinding()]
param(
    [string]$EnvFilePath = ''
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($EnvFilePath)) {
    $EnvFilePath = Join-Path $PSScriptRoot '..\..\.env'
}

if (-not (Test-Path $EnvFilePath)) {
    Write-Error "File not found: $EnvFilePath"
    exit 1
}

$mappings = @{
    # Core and overlap-safe mappings
    'GITHUB_PERSONAL_ACCESS_TOKEN' = @('github.token', 'github.personal_access_token')
    'BRAVE_API_KEY'                = @('brave-search.api_key', 'brave.api_key')
    'TODOIST_API_TOKEN'            = @('todoist.api_key')
    'SUPABASE_ACCESS_TOKEN'        = @('supabase.access_token')
    'NOTION_API_KEY'               = @('notion.key', 'notion.internal_integration_token')
    'FIRECRAWL_API_KEY'            = @('firecrawl.api_key', 'firecrawl.key')
    'SENTRY_AUTH_TOKEN'            = @('sentry.auth_token')
    'SENTRY_ORG'                   = @('sentry.org')

    # Custom runtime catalog mappings
    'CLOUDFLARE_API_TOKEN'         = @('cloudflare.api_token')
    'CLOUDFLARE_ACCOUNT_ID'        = @('cloudflare.account_id')
    'SNYK_TOKEN'                   = @('snyk.api_key')
    'MEM0_API_KEY'                 = @('mem0.key')
    'PUBMED_EMAIL'                 = @('pubmed.email')
    'QDRANT_URL'                   = @('qdrant.url')
    'QDRANT_API_KEY'               = @('qdrant.api_key')
    'SEARXNG_URL'                  = @('searxng.url')
    'NEXUS_API_KEY'                = @('nexus.key')
}

function Normalize-EnvValue {
    param([string]$Value)
    $trimmed = $Value.Trim()
    if (
        ($trimmed.StartsWith('"') -and $trimmed.EndsWith('"')) -or
        ($trimmed.StartsWith("'") -and $trimmed.EndsWith("'"))
    ) {
        return $trimmed.Substring(1, $trimmed.Length - 2)
    }
    return $trimmed
}

Write-Host '+--------------------------------------------+' -ForegroundColor Cyan
Write-Host '|   Docker MCP Secrets Configuration         |' -ForegroundColor Cyan
Write-Host '+--------------------------------------------+' -ForegroundColor Cyan
Write-Host "Reading secrets from $EnvFilePath..." -ForegroundColor Yellow
Write-Host ''

$setCount = 0
$failCount = 0
$seenEnv = New-Object System.Collections.Generic.HashSet[string]

Get-Content $EnvFilePath | ForEach-Object {
    $line = $_.Trim()
    if ([string]::IsNullOrWhiteSpace($line) -or $line.StartsWith('#')) {
        return
    }

    $parts = $line.Split('=', 2)
    if ($parts.Count -ne 2) {
        return
    }

    $envName = $parts[0].Trim()
    $envValue = Normalize-EnvValue -Value $parts[1]
    if ([string]::IsNullOrWhiteSpace($envValue)) {
        return
    }

    $seenEnv.Add($envName) | Out-Null
    if (-not $mappings.ContainsKey($envName)) {
        return
    }

    foreach ($secretName in $mappings[$envName]) {
        Write-Host "  Setting $secretName..." -NoNewline
        try {
            $envValue | docker mcp secret set $secretName 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Host ' [OK]' -ForegroundColor Green
                $setCount++
            }
            else {
                Write-Host ' [FAIL]' -ForegroundColor Red
                $failCount++
            }
        }
        catch {
            Write-Host ' [FAIL]' -ForegroundColor Red
            $failCount++
        }
    }
}

$missingMapped = @()
foreach ($envName in $mappings.Keys) {
    if (-not $seenEnv.Contains($envName)) {
        $missingMapped += $envName
    }
}

Write-Host ''
Write-Host '--------------------------------------------' -ForegroundColor Cyan
Write-Host "Results: $setCount secrets set, $failCount failed" -ForegroundColor $(if ($failCount -eq 0) { 'Green' } else { 'Yellow' })
if ($missingMapped.Count -gt 0) {
    Write-Host 'Missing optional env vars (not set):' -ForegroundColor Yellow
    foreach ($name in $missingMapped | Sort-Object) {
        Write-Host "  - $name" -ForegroundColor Gray
    }
}
Write-Host "Run 'docker mcp secret ls' to verify." -ForegroundColor Gray
