# PowerShell script to set up Docker MCP Lazy-Load Servers for Antigravity
# Run this script ONCE to initialize all servers
# Usage: .\setup-mcp-lazy-load.ps1

$EnvFilePath = ".env"
if (-not (Test-Path $EnvFilePath)) {
    Write-Error "File not found: $EnvFilePath"
    exit 1
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setting up Docker MCP Lazy-Load Servers" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Store environment variables from .env
$envVars = @{}
Get-Content $EnvFilePath | ForEach-Object {
    $line = $_.Trim()
    if ([string]::IsNullOrWhiteSpace($line) -or $line.StartsWith("#")) { return }
    $parts = $line.Split("=", 2)
    if ($parts.Count -eq 2) {
        $envVars[$parts[0].Trim()] = $parts[1].Trim()
    }
}

# ============================================================================
# SERVERS TO CONFIGURE (from your docker-compose.yml)
# ============================================================================

$servers = @(
    "filesystem",
    "git",
    "github",
    "memory",
    "sequential-thinking",
    "brave-search",
    "todoist",
    "linear",
    "playwright",
    "desktop-commander",
    "pylance",
    "sqlite",
    "lsmcp",
    "rust-analyzer",
    "clangd",
    "serena",
    "context7",
    "shrimp-task-manager"
)

# ============================================================================
# ENABLE ALL SERVERS
# ============================================================================

Write-Host "`nEnabling MCP servers in Docker..." -ForegroundColor Yellow

$enabledCount = 0
foreach ($server in $servers) {
    Write-Host "  Enabling $server..." -NoNewline
    
    try {
        $output = docker mcp server enable $server 2>&1
        Write-Host " [OK]" -ForegroundColor Green
        $enabledCount++
    }
    catch {
        Write-Host " [SKIPPED]" -ForegroundColor Yellow
    }
}

Write-Host "`nEnabled $enabledCount/$($servers.Count) servers" -ForegroundColor Cyan

# ============================================================================
# SET SECRETS FROM .env
# ============================================================================

Write-Host "`nSetting environment secrets..." -ForegroundColor Yellow

$secretMappings = @{
    "GITHUB_PERSONAL_ACCESS_TOKEN" = "github.token"
    "BRAVE_API_KEY"                = "brave-search.api_key"
    "TODOIST_API_TOKEN"            = "todoist.api_token"
    "LINEAR_API_KEY"               = "linear.api_key"
    "PGHOST"                       = "postgres.host"
    "PGUSER"                       = "postgres.user"
    "PGPASSWORD"                   = "postgres.password"
    "PGDATABASE"                   = "postgres.database"
    "SUPABASE_URL"                 = "supabase.url"
    "SUPABASE_ANON_KEY"            = "supabase.anon_key"
    "SUPABASE_SERVICE_ROLE_KEY"    = "supabase.service_role_key"
    "MONGODB_URI"                  = "mongodb.uri"
    "CLOUDFLARE_API_TOKEN"         = "cloudflare.api_token"
    "CLOUDFLARE_ACCOUNT_ID"        = "cloudflare.account_id"
    "SNYK_TOKEN"                   = "snyk.token"
    "GITGUARDIAN_API_KEY"          = "gitguardian.api_key"
}

$secretSetCount = 0
foreach ($envVar in $secretMappings.Keys) {
    if ($envVars.ContainsKey($envVar) -and -not [string]::IsNullOrWhiteSpace($envVars[$envVar])) {
        $secretName = $secretMappings[$envVar]
        $value = $envVars[$envVar]
        
        Write-Host "  Setting $secretName..." -NoNewline
        
        try {
            $value | docker mcp secret set $secretName 2>&1 | Out-Null
            Write-Host " [OK]" -ForegroundColor Green
            $secretSetCount++
        }
        catch {
            Write-Host " [SKIPPED]" -ForegroundColor Yellow
        }
    }
}

Write-Host "`nSet $secretSetCount secrets from .env" -ForegroundColor Cyan

# ============================================================================
# SUMMARY & NEXT STEPS
# ============================================================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Open a NEW PowerShell window" -ForegroundColor White
Write-Host "2. Run: docker mcp gateway run --port 8080 --transport sse" -ForegroundColor Cyan
Write-Host "3. Keep that window open (it's your gateway)" -ForegroundColor White
Write-Host "4. In Antigravity, add the Docker gateway connection" -ForegroundColor White
Write-Host "5. Install MCP Vault: pip install mcpv" -ForegroundColor White
Write-Host "6. Add MCP Vault to Antigravity config for 90% context reduction" -ForegroundColor White

Write-Host "`nVerify setup:" -ForegroundColor Yellow
Write-Host "  docker mcp server list          # See all servers" -ForegroundColor Cyan
Write-Host "  docker mcp secret ls            # See all secrets" -ForegroundColor Cyan

Write-Host "`n"
