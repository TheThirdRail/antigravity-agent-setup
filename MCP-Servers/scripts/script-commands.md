# MCP Server Script Commands

Quick reference for shared MCP setup scripts in `MCP-Servers/scripts`.

## Prerequisites

1. Open PowerShell in `MCP-Servers/scripts`.
2. Ensure Docker Desktop is running.
3. Ensure project root `.env` exists for secret setup.

## Install MCP Server Entries

```powershell
.\install-mcp-servers.ps1 -Vendor google -ServerNames "filesystem", "git"
.\install-mcp-servers.ps1 -Vendor openai -ServerNames "filesystem", "git"
.\install-mcp-servers.ps1 -Vendor anthropic -ServerNames "filesystem", "git"
```

Vendor target defaults:
- `google`: `%LOCALAPPDATA%\Google\Antigravity\User Data\User\mcp_config.json`
- `openai`: `~\.agents\mcp_config.json`, `~\.codex\mcp_config.json`, `%APPDATA%\OpenAI\ChatGPT\mcp_config.json`
- `anthropic`: `~\.claude.json`, `%APPDATA%\Claude\claude_desktop_config.json`

Optional target filters:
- OpenAI: `-IncludeAgents:$false`, `-IncludeCodex:$false`, `-IncludeChatGPT:$false`
- Anthropic: `-IncludeClaudeCode:$false`, `-IncludeClaudeDesktop:$false`

## Set MCP Secrets

```powershell
.\set-mcp-secrets.ps1
.\set-mcp-secrets.ps1 -EnvFilePath "..\..\.env"
```

## Setup MCP Lazy Load

```powershell
.\setup_lazy_load.ps1 -ClientName "Google Antigravity"
.\setup_lazy_load.ps1 -ClientName "OpenAI ChatGPT/Codex"
.\setup_lazy_load.ps1 -ClientName "Anthropic Claude Code"
```

## Dry Run

```powershell
.\install-mcp-servers.ps1 -Vendor google -DryRun -ServerNames "filesystem"
```
