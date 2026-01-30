<#
.SYNOPSIS
    Generates a recursive structure map of the current directory, including file summaries and function signatures.
    Designed to serve as a lightweight "structure.md" or "JSON DB" for AI context.

.DESCRIPTION
    Scans the current directory (skipping git/node_modules), lists files,
    and attempts to regex-extract function definitions to give a high-level map.
    
.PARAMETER OutputFormat
    markdown (default) or json
#>

param(
    [string]$Path = ".",
    [string]$OutputFormat = "markdown",
    [string]$OutputFile = "PROJECT_STRUCTURE.md"
)

$ExcludeDirs = @(".git", ".agent", ".claude", ".cursor", "node_modules", "dist", "build", "coverage", "__pycache__")
$ExcludeExtensions = @(".png", ".jpg", ".svg", ".ico", ".lock", ".log", ".zip", ".tar", ".gz")

function Get-FunctionSignatures {
    param([string]$FilePath)
    $Content = Get-Content $FilePath -ErrorAction SilentlyContinue
    if (-not $Content) { return @() }
    
    $Signatures = @()
    
    # Simple regex for finding function definitions (Language agnostic-ish)
    # Python: def foo(bar):
    # JS/TS: function foo(bar) or const foo = (bar) =>
    # PS: function foo {
    
    $Ext = [System.IO.Path]::GetExtension($FilePath).ToLower()
    
    if ($Ext -eq ".py") {
        $Signatures += $Content | Select-String "^\s*(async\s+)?def\s+([a-zA-Z0-9_]+)\s*\(" | ForEach-Object { $_.Line.Trim() }
        $Signatures += $Content | Select-String "^\s*class\s+([a-zA-Z0-9_]+)" | ForEach-Object { $_.Line.Trim() }
    }
    elseif ($Ext -in @(".js", ".ts", ".jsx", ".tsx")) {
        $Signatures += $Content | Select-String "function\s+([a-zA-Z0-9_]+)" | ForEach-Object { $_.Line.Trim() }
        $Signatures += $Content | Select-String "const\s+([a-zA-Z0-9_]+)\s*=\s*(\(|async)" | ForEach-Object { $_.Line.Trim() }
        $Signatures += $Content | Select-String "class\s+([a-zA-Z0-9_]+)" | ForEach-Object { $_.Line.Trim() }
    }
    elseif ($Ext -eq ".ps1") {
        $Signatures += $Content | Select-String "function\s+([a-zA-Z0-9_-]+)" | ForEach-Object { $_.Line.Trim() }
    }
    
    return $Signatures
}

$Structure = @()
$Files = Get-ChildItem -Path $Path -Recurse -File | Where-Object { 
    $RelPath = $_.FullName.Replace($PWD.Path, "")
    $Parts = $RelPath.Split([System.IO.Path]::DirectorySeparatorChar)
    $Skip = $false
    foreach ($Part in $Parts) {
        if ($Part -in $ExcludeDirs) { $Skip = $true; break }
    }
    if (-not $Skip) {
        if ($_.Extension -in $ExcludeExtensions) { $Skip = $true }
    }
    -not $Skip
}

foreach ($File in $Files) {
    Write-Host "Scanning $($File.Name)..." -ForegroundColor DarkGray
    $Sigs = Get-FunctionSignatures -FilePath $File.FullName
    
    $Item = @{
        Path      = $File.FullName.Replace($PWD.Path, "").TrimStart("\/")
        Size      = $File.Length
        Functions = $Sigs
    }
    $Structure += $Item
}

if ($OutputFormat -eq "json") {
    $Structure | ConvertTo-Json -Depth 3 | Out-File $OutputFile
}
else {
    $Md = "# Project Structure Map`n`nGenerated: $(Get-Date)`n`n"
    foreach ($Item in $Structure) {
        $Md += "## $($Item.Path)`n"
        if ($Item.Functions.Count -gt 0) {
            $Md += "### Symbols`n"
            foreach ($Sig in $Item.Functions) {
                $Md += "- ``$Sig``n"
            }
        }
        $Md += "`n"
    }
    $Md | Out-File $OutputFile
}

Write-Host "Structure generated at: $OutputFile" -ForegroundColor Green
