# AI Agent Setup Kit (OpenAI Codex + Anthropic Claude Code + Google Antigravity)

This repository helps you set up a practical AI coding workspace with:
- reusable skills
- repeatable workflows
- safety rules
- MCP server integrations
- local archive tools for project memory and search

This guide is written for non-technical and low-technical users. Copy and paste the commands exactly as shown.

## What You Get

- OpenAI catalog under `Agent/OpenAI/`
- Anthropic catalog under `Agent/Anthropic/`
- Google catalog under `Agent/Google/`
- MCP catalog under `MCP-Servers/mcp-docker-stack/docker-mcp-catalog.yaml`
- Local helper scripts under vendor-specific `Scripts/` folders (root scripts are deprecated)
- Local archive storage under `Agent-Context/` (kept local, not versioned)

## Before You Start

Install these first:

1. Git
2. Docker Desktop (with Docker MCP support available)
3. PowerShell (Windows 10/11 is fine)
4. Your AI client:
- OpenAI Codex and/or ChatGPT desktop app
- Anthropic Claude Code and/or Claude Desktop
- Google Antigravity

## One-Time Repo Setup

From a terminal:

```powershell
git clone https://github.com/TheThirdRail/antigravity-agent-setup.git
cd antigravity-agent-setup
Copy-Item example.env .env
```

Open `.env` and fill in keys you actually use. Start with:

- `GITHUB_PERSONAL_ACCESS_TOKEN`
- `BRAVE_API_KEY`

Use `secrets-acquisition-guide.md` if you need help getting keys.

## Setup Path A: OpenAI Codex

Use this path if you want Codex-style skills, rules, and automations.

### Install OpenAI Artifacts

```powershell
cd Agent\OpenAI\Scripts
.\validate-codex-openai.ps1
.\install-rules.ps1 -DryRun
.\install-rules.ps1
```

What this installs:

- `~/.codex/AGENTS.md`
- `~/.codex/rules/default.rules`
- `~/.codex/skills/*`
- `~/.codex/automations/*.automation.md`

Optional mirror to `~/.agents/*` too:

```powershell
.\install-rules.ps1 -Target both
```

### Configure MCP for OpenAI Clients

```powershell
..\..\..\MCP-Servers\scripts\install-mcp-servers.ps1 -Vendor openai -ServerNames "filesystem", "github", "desktop-commander", "context7"
..\..\..\MCP-Servers\scripts\set-mcp-secrets.ps1
..\..\..\MCP-Servers\scripts\setup_lazy_load.ps1 -ClientName "OpenAI ChatGPT/Codex"
```

Then restart Codex/ChatGPT so it reloads config.

## Setup Path B: Google Antigravity

Use this path if you want slash-command workflows in Antigravity.

### Install Google Artifacts

```powershell
cd Agent\Google\Scripts
.\deprecation-checker.ps1 -DryRun
.\deprecation-checker.ps1
.\install-rules.ps1
.\install-skills.ps1
.\install-workflows.ps1
```

What this installs:

- `~/.gemini/GEMINI.md`
- `~/.gemini/antigravity/skills/*`
- `~/.gemini/antigravity/global_workflows/*.md`

### Configure MCP for Google

```powershell
..\..\..\MCP-Servers\scripts\install-mcp-servers.ps1 -Vendor google -ServerNames "filesystem", "github", "desktop-commander", "context7"
..\..\..\MCP-Servers\scripts\set-mcp-secrets.ps1
..\..\..\MCP-Servers\scripts\setup_lazy_load.ps1 -ClientName "Google Antigravity"
```

Then restart Antigravity.

## Setup Path C: Anthropic Claude Code

Use this path if you want Anthropic subagents with canonical `CLAUDE.md` policy routing.

### Install Anthropic Artifacts

```powershell
cd Agent\Anthropic\Scripts
.\validate-rule-length.ps1
.\validate-subagents.ps1
.\deprecation-checker.ps1 -DryRun
.\install-rules.ps1
.\install-skills.ps1
.\install-subagents.ps1
.\install-settings.ps1
```

What this installs:

- `~/.claude/CLAUDE.md`
- `~/.claude/rules/*.md`
- `~/.claude/skills/*`
- `~/.claude/agents/*.md`
- `~/.claude/settings.json` (merged baseline)

### Configure MCP for Anthropic

```powershell
..\..\..\MCP-Servers\scripts\install-mcp-servers.ps1 -Vendor anthropic -ServerNames "filesystem", "github", "desktop-commander", "context7"
..\..\..\MCP-Servers\scripts\set-mcp-secrets.ps1
..\..\..\MCP-Servers\scripts\setup_lazy_load.ps1 -ClientName "Anthropic Claude Code"
```

Then restart Claude Code/Claude Desktop.

## MCP Catalog Overview

The project catalog currently defines 46 MCP servers in categories like:

- development and command execution
- search and research
- security scanning
- data and vector databases
- frontend and utility tools

Main file:

- `MCP-Servers/mcp-docker-stack/docker-mcp-catalog.yaml`

## Local Archives (Project Memory)

This repo includes archive skills that use local data stores:

- semantic docs archive (Chroma)
- code structure graph (SQLite)
- durable memory notes (SQLite)
- git-history and code search helpers

Local archive path:

- `Agent-Context/Archives/`

Important:

- `Agent-Context/` is local-only and ignored by Git
- do not store secrets in archive data

## Folder Map

```text
.
├── Agent/
│   ├── OpenAI/
│   │   ├── AGENTS.md
│   │   ├── default.rules
│   │   ├── Automations/
│   │   ├── Skills/
│   │   └── Scripts/
│   ├── Anthropic/
│   │   ├── Rules/
│   │   ├── Skills/
│   │   ├── Subagents/
│   │   └── Scripts/
│   └── Google/
│       ├── Rules/
│       ├── Skills/
│       ├── Workflows/
│       └── Scripts/
├── MCP-Servers/
│   ├── mcp-docker-stack/
│   └── scripts/
├── deprecated-Scripts/
├── Agent-Context/
├── example.env
├── secrets-acquisition-guide.md
└── README.md
```

## Which File Should I Read Next?

If you use OpenAI Codex:

- `Agent/OpenAI/AGENTS.md`
- `Agent/OpenAI/Scripts/script-commands.md`
- `codex-sample-workflow.md`

If you use Google Antigravity:

- `Agent/Google/Rules/GEMINI.md`
- `Agent/Google/Scripts/script-commands.md`
- `antigravity-sample-workflow.md`

If you use Anthropic Claude Code:

- `Agent/Anthropic/Rules/CLAUDE.md`
- `Agent/Anthropic/Scripts/script-commands.md`
- `claude-code-sample-workflow.md`

## Common Problems

### Script says it cannot run

Use:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### MCP command fails

- make sure Docker Desktop is running
- make sure your `.env` file exists and has needed keys
- rerun `MCP-Servers/scripts/set-mcp-secrets.ps1`

### Changes do not appear in the AI client

- restart the client after install scripts run

## Safe Daily Update Routine

OpenAI:

```powershell
cd Agent\OpenAI\Scripts
.\install-rules.ps1
```

Google:

```powershell
cd Agent\Google\Scripts
.\install-rules.ps1
.\install-skills.ps1
.\install-workflows.ps1
```

Anthropic:

```powershell
cd Agent\Anthropic\Scripts
.\install-rules.ps1
.\install-skills.ps1
.\install-subagents.ps1
.\install-settings.ps1
```

## License

MIT
