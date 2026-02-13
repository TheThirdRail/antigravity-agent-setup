# MCP Server Script Commands

Quick reference for the shared MCP gateway setup scripts in `MCP-Servers/scripts`.

## Prerequisites

1. Open PowerShell in `MCP-Servers/scripts`.
2. Ensure Docker Desktop is running.
3. Ensure project root `.env` exists for secret setup.
4. Ensure runtime catalog exists: `MCP-Servers/mcp-docker-stack/docker-mcp-catalog.runtime.yaml`.

## 1) Sync Client Gateway Config

This updates clients to use:
- `--transport stdio`
- `--registry <repo>/MCP-Servers/mcp-docker-stack/registry.all.yaml`
- `--additional-catalog <repo>/MCP-Servers/mcp-docker-stack/docker-mcp-catalog.runtime.yaml`

```powershell
.\install-mcp-servers.ps1 -Vendor openai
.\install-mcp-servers.ps1 -Vendor google
.\install-mcp-servers.ps1 -Vendor anthropic
.\install-mcp-servers.ps1 -Vendor all
```

Targets:
- `openai` -> `~/.codex/config.toml`
- `google` -> `~/.gemini/antigravity/mcp_config.json`
- `anthropic` -> `~/.claude.json`

Dry run:

```powershell
.\install-mcp-servers.ps1 -Vendor all -DryRun
```

## 2) Set Docker MCP Secrets from `.env`

```powershell
.\set-mcp-secrets.ps1
.\set-mcp-secrets.ps1 -EnvFilePath "..\..\.env"
```

## 3) Generate Registry + Probe All Servers

This script:
- Regenerates `registry.all.yaml` from inventory catalog (`docker-mcp-catalog.yaml`)
- Validates overlap policy (runtime catalog cannot include official-overlap servers)
- Syncs Docker's configured `custom-stack.yaml` to the runtime catalog
- Optionally sets secrets
- Probes each server through gateway in isolated mode
- Writes reports to `MCP-Servers/reports`

```powershell
.\setup_lazy_load.ps1 -ClientName "All Clients"
.\setup_lazy_load.ps1 -ClientName "All Clients" -SkipSecrets
```

Outputs:
- `MCP-Servers/reports/mcp-health-<timestamp>.json`
- `MCP-Servers/reports/mcp-health-<timestamp>.md`

## 4) Manual Gateway Run (for debugging)

```powershell
docker mcp gateway run --transport stdio `
  --registry "D:\Coding\Tools\mcp-docker-stack\MCP-Servers\mcp-docker-stack\registry.all.yaml" `
  --additional-catalog "D:\Coding\Tools\mcp-docker-stack\MCP-Servers\mcp-docker-stack\docker-mcp-catalog.runtime.yaml"
```

## 5) Spot-check a Single Server

```powershell
docker mcp tools count `
  --gateway-arg="--registry=D:\Coding\Tools\mcp-docker-stack\MCP-Servers\mcp-docker-stack\registry.all.yaml" `
  --gateway-arg="--additional-catalog=D:\Coding\Tools\mcp-docker-stack\MCP-Servers\mcp-docker-stack\docker-mcp-catalog.runtime.yaml" `
  --gateway-arg="--servers=serena"
```
