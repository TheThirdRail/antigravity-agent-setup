[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[a-z][a-z0-9-]{0,62}[a-z0-9]$')]
    [ValidateLength(2, 64)]
    [string]$Name,

    [Parameter(Mandatory = $false)]
    [string]$Path = '.'
)

$ErrorActionPreference = 'Stop'

$targetRoot = (Resolve-Path $Path -ErrorAction Stop).Path
$targetFile = Join-Path $targetRoot "$Name.md"

if (Test-Path $targetFile) {
    Write-Error "Subagent file already exists: $targetFile"
    exit 1
}

$template = @"
---
name: $Name
description: |
  Briefly describe when to invoke this subagent.
---

<subagent name="$Name" version="1.0.0">
  <metadata>
    <owner>anthropic</owner>
    <format>embedded-xml-markdown</format>
  </metadata>

  <purpose>Describe the outcome this subagent should deliver.</purpose>

  <when_to_use>
    <trigger>List trigger conditions for activation.</trigger>
  </when_to_use>

  <constraints>
    <rule>List mandatory guardrails and limits.</rule>
  </constraints>

  <workflow>
    <step number="1" name="Initial Step">
      <action>Describe the first deterministic action.</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>Define what must be true when complete.</criterion>
  </output_contract>

  <handoffs>
    <route>/analyze</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>
"@

if ($PSCmdlet.ShouldProcess($targetFile, 'Create subagent template')) {
    Set-Content -Path $targetFile -Value $template -Encoding UTF8
    Write-Host "Created subagent template: $targetFile" -ForegroundColor Green
}
