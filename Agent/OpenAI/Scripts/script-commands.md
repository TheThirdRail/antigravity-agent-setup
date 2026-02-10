# Script Commands (OpenAI Codex)

Quick reference for `Agent/OpenAI/Scripts`.

## Core Runtime Model

- Canonical instructions source: `Agent/OpenAI/AGENTS.md`
- Repo runtime instructions mirror: `AGENTS.md`
- Consolidated rules source: `Agent/OpenAI/default.rules`
- Automation templates source: `Agent/OpenAI/Automations/*.automation.md`
- Installed Codex targets:
  - `~/.codex/AGENTS.md`
  - `~/.codex/rules/default.rules`
  - `~/.codex/skills/<skill>/`
  - `~/.codex/automations/*.automation.md`
- Optional compatibility mirror: `~/.agents/*` via `-Target agents|both` or `-MirrorAgents`

## Validate

```powershell
.\validate-codex-openai.ps1
```

## Full Install (Recommended)

```powershell
.\install-rules.ps1
```

Options:

```powershell
.\install-rules.ps1 -Target codex|agents|both -Scope global|project|both -DryRun
.\install-rules.ps1 -MirrorAgents -DryRun
.\install-rules.ps1 -SkipSkills -SkipAutomations -DryRun
```

## Individual Installers

```powershell
.\install-agents.ps1 -Target codex|agents|both -Scope global|project|both -DryRun
.\install-codex-rules.ps1 -Target codex|agents|both -DryRun
.\install-skills.ps1 -Target codex|agents|both -DryRun
.\install-automations.ps1 -Target codex|agents|both -DryRun
```

## Deprecation Cleanup

```powershell
.\deprecation-checker.ps1 -DryRun
```

## MCP Setup

```powershell
.\install-mcp-servers.ps1 -ServerNames "filesystem", "git"
.\set-mcp-secrets.ps1
.\setup_lazy_load.ps1
```

## Deprecated Scripts

Deprecated scripts are archived in:

- `Agent/OpenAI/Scripts/deprecated-scripts/build-agents.ps1`
- `Agent/OpenAI/Scripts/deprecated-scripts/install-workflows.ps1`
