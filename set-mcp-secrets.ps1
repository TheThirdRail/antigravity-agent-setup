# PowerShell script to set Docker MCP secrets from .env file

$EnvFilePath = ".env"
if (-not (Test-Path $EnvFilePath)) {
    Write-Error "File not found: $EnvFilePath"
    exit 1
}

# Define mapping from .env variable name to MCP secret name
$Mappings = @{
    "GITHUB_PERSONAL_ACCESS_TOKEN" = "github.token"
    "TODOIST_API_TOKEN"            = "todoist.api_token"
    "LINEAR_API_KEY"               = "linear.api_key"
    "BRAVE_API_KEY"                = "brave-search.api_key"
    "PGHOST"                       = "postgres.host"
    "PGUSER"                       = "postgres.user"
    "PGPASSWORD"                   = "postgres.password"
    "PGDATABASE"                   = "postgres.database"
    "SUPABASE_URL"                 = "supabase.url"
    "SUPABASE_ANON_KEY"            = "supabase.anon_key"
    "SUPABASE_SERVICE_ROLE_KEY"    = "supabase.service_role_key"
    "NEON_API_KEY"                 = "neon.api_key"
    "DATABASE_URL"                 = "neon.database_url"
    "MONGODB_URI"                  = "mongodb.uri"
    "CLOUDFLARE_API_TOKEN"         = "cloudflare.api_token"
    "CLOUDFLARE_ACCOUNT_ID"        = "cloudflare.account_id"
    "SNYK_TOKEN"                   = "snyk.token"
    "GITGUARDIAN_API_KEY"          = "gitguardian.api_key"
    "FIRECRAWL_API_KEY"            = "firecrawl.key"
    "TAVILY_API_KEY"               = "tavily.key"
    "NOTION_API_KEY"               = "notion.key"
    "MEM0_API_KEY"                 = "mem0.key"
}

Write-Host "Reading secrets from $EnvFilePath..." -ForegroundColor Cyan

# Read .env file line by line
Get-Content $EnvFilePath | ForEach-Object {
    $line = $_.Trim()
    
    # Skip comments and empty lines
    if ([string]::IsNullOrWhiteSpace($line) -or $line.StartsWith("#")) {
        return
    }

    # Split key and value (handling possible '=' in value)
    $parts = $line.Split("=", 2)
    if ($parts.Count -lt 2) { return }
    
    $Key = $parts[0].Trim()
    $Value = $parts[1].Trim()

    # Check if this env var is in our mapping list
    if ($Mappings.ContainsKey($Key)) {
        $SecretName = $Mappings[$Key]
        
        Write-Host "Setting secret: $SecretName (from $Key)" -NoNewline
        
        # Pipe value to docker mcp secret set
        try {
            $Value | docker mcp secret set $SecretName
            Write-Host " [OK]" -ForegroundColor Green
        }
        catch {
            Write-Host " [FAILED]" -ForegroundColor Red
            Write-Error $_
        }
    }
}

Write-Host "`nAll mapped secrets processed." -ForegroundColor Cyan
Write-Host "Run 'docker mcp secret ls' to verify." -ForegroundColor Yellow
