<#
.SYNOPSIS
    Generate SCIP index for a Python project.
.PARAMETER ProjectPath
    Path to the project root
.PARAMETER ProjectName
    Optional name for the index file (defaults to folder name)
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath,
    
    [string]$ProjectName
)

$ErrorActionPreference = "Stop"

# Validate project path
if (-not (Test-Path $ProjectPath)) {
    Write-Host "Error: Project path not found: $ProjectPath" -ForegroundColor Red
    exit 1
}

$ProjectPath = Resolve-Path $ProjectPath

# Determine project name
if (-not $ProjectName) {
    $ProjectName = Split-Path -Leaf $ProjectPath
}

# Locate output directory

# Deriving output directory relative to the project being indexed
$ProjectRoot = Resolve-Path $ProjectPath
$OutputDir = Join-Path $ProjectRoot "Agent-Context\Archives\code-index"
$OutputFile = Join-Path $OutputDir "$ProjectName.scip"

# Ensure output directory exists
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

Write-Host "Indexing Python project: $ProjectPath" -ForegroundColor Cyan
Write-Host "Output: $OutputFile" -ForegroundColor Cyan

# Check for scip-python
$ScipPy = Get-Command scip-python -ErrorAction SilentlyContinue
if (-not $ScipPy) {
    Write-Host "Error: scip-python not found. Install with: pip install scip-python" -ForegroundColor Red
    exit 1
}

# Run indexer
try {
    scip-python index --project-name $ProjectName --output $OutputFile $ProjectPath
    
    if (Test-Path $OutputFile) {
        $Size = (Get-Item $OutputFile).Length / 1KB
        Write-Host "✓ Created index: $OutputFile ($([math]::Round($Size, 2)) KB)" -ForegroundColor Green
    }
    else {
        Write-Host "Warning: Index file not created" -ForegroundColor Yellow
    }
}
catch {
    Write-Host "Error during indexing: $_" -ForegroundColor Red
    exit 1
}
