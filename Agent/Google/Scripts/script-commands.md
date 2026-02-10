# Script Commands (Google)

Quick reference for `Agent/Google/Scripts`.

## Prerequisites

1. Open PowerShell in `Agent/Google/Scripts`.
2. Ensure project root `.env` is configured.
3. Ensure Docker Desktop is running for MCP scripts.

## Install and Sync

```powershell
.\deprecation-checker.ps1
.\install-rules.ps1
.\install-skills.ps1
.\install-workflows.ps1
```

Targets:
- Rules: `~\.gemini\GEMINI.md`
- Skills: `~\.gemini\antigravity\skills`
- Workflows: `~\.gemini\antigravity\global_workflows`

Workspace-local install targets (via `move-local-*` scripts):
- Rules: `.agent\rules`
- Skills: `.agent\skills`
- Workflows: `.agent\workflows`

## MCP Setup

```powershell
.\install-mcp-servers.ps1 -ServerNames "filesystem", "git"
.\set-mcp-secrets.ps1
.\setup_lazy_load.ps1
```

Targets:
- MCP config: `%LOCALAPPDATA%\Google\Antigravity\User Data\User\mcp_config.json`

## Dry Run

```powershell
.\deprecation-checker.ps1 -DryRun
.\install-rules.ps1 -DryRun
.\install-skills.ps1 -DryRun
.\install-workflows.ps1 -DryRun
```
