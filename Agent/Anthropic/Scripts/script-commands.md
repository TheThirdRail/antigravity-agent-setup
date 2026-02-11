# Script Commands (Anthropic)

Quick reference for `Agent/Anthropic/Scripts`.

## Prerequisites

1. Open PowerShell in `Agent/Anthropic/Scripts`.
2. Ensure project root `.env` is configured.
3. Ensure Docker Desktop is running for MCP scripts.

## Install and Sync

```powershell
.\deprecation-checker.ps1
.\install-rules.ps1
.\install-skills.ps1
.\install-subagents.ps1
.\install-settings.ps1
```

Targets:
- Canonical memory: `~\.claude\CLAUDE.md`
- Canonical rules: `~\.claude\rules\*.md` (unified domain packs)
- Skills: `~\.claude\skills\<skill>\`
- Subagents: `~\.claude\agents\*.md`
- Settings: `~\.claude\settings.json` (merged baseline)

## Install Options

```powershell
.\install-rules.ps1 -IncludeLegacyRules
```

- `-IncludeLegacyRules` installs compatibility wrapper rule files in addition to canonical unified rules.

## Validation

```powershell
.\validate-rule-length.ps1
.\validate-subagents.ps1
```

Validation behavior:
- `validate-rule-length.ps1` enforces active rule files <= 12,000 characters.
- `validate-subagents.ps1` validates XML subagent structure, frontmatter consistency, and canonical handoff routes.

## MCP Setup

```powershell
..\..\..\MCP-Servers\scripts\install-mcp-servers.ps1 -Vendor anthropic -ServerNames "filesystem", "git"
..\..\..\MCP-Servers\scripts\set-mcp-secrets.ps1
..\..\..\MCP-Servers\scripts\setup_lazy_load.ps1 -ClientName "Anthropic Claude Code"
```

MCP targets (default):
- `~\.claude.json` (Claude Code)
- `%APPDATA%\Claude\claude_desktop_config.json` (Claude Desktop)

Use flags to limit targets:
- `-IncludeClaudeCode:$false`
- `-IncludeClaudeDesktop:$false`

## MCP Runtime Cleanup (After Use)

Terminate stale MCP runtime processes after MCP-heavy sessions:

```powershell
Get-Process -Name "docker-mcp" -ErrorAction SilentlyContinue | Stop-Process -Force
```

Optional verification:

```powershell
Get-Process -Name "docker-mcp" -ErrorAction SilentlyContinue
```

## Dry Run

```powershell
.\deprecation-checker.ps1 -DryRun
.\install-rules.ps1 -DryRun
.\install-subagents.ps1 -DryRun
.\install-settings.ps1 -DryRun
..\..\..\MCP-Servers\scripts\install-mcp-servers.ps1 -Vendor anthropic -DryRun -ServerNames "filesystem"
```

## Migration Note

- Anthropic subagents are now the canonical execution route.
- Legacy workflows are archived under `Agent/Anthropic/deprecated-Workflows/` and are not installed by default.
- Legacy compatibility rule wrappers, including `GEMINI.md`, are archived under `Agent/Anthropic/deprecated-Rules/`.
- Canonical memory policy is `CLAUDE.md`.
