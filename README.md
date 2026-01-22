# Antigravity Agent Setup

A comprehensive toolkit for configuring Google Antigravity AI agents with custom skills, workflows, rules, and MCP (Model Context Protocol) servers.

## 🎯 What This Repo Does

This repository provides everything you need to supercharge your Antigravity AI coding assistant:

| Component | Purpose |
|-----------|---------|
| **Skills** | Reusable AI capabilities (test generation, API building, etc.) |
| **Workflows** | Step-by-step automation sequences (TDD, research, etc.) |
| **Rules** | Behavioral constraints and guardrails for the agent |
| **MCP Servers** | External tools via Docker MCP Gateway (databases, search, etc.) |

## 📁 Folder Structure

```
antigravity-agent-setup/
├── Agent/                    # Source files for agent configuration
│   ├── Skills/              # AI skill definitions (XML-in-Markdown)
│   ├── Workflows/           # Workflow definitions (XML-in-Markdown)
│   └── Rules/               # Rule definitions (XML-in-Markdown)
├── MCP-Servers/             # Docker MCP server catalog
│   └── mcp-docker-stack/    # Custom MCP server definitions
├── Scripts/                 # PowerShell installation scripts
├── .agent/                  # Local workspace copy (gitignored)
├── example.env              # Template for API keys and secrets
└── README.md
```

## 🚀 Quick Start

### 1. Clone and Configure
```powershell
git clone https://github.com/YourUsername/antigravity-agent-setup.git
cd antigravity-agent-setup

# Copy and fill in your API keys
Copy-Item example.env .env
# Edit .env with your actual credentials
```

### 2. Install Components
```powershell
# Install skills globally
.\Scripts\install-skills.ps1

# Install workflows globally
.\Scripts\install-workflows.ps1

# Install rules globally
.\Scripts\install-rules.ps1

# Set MCP secrets from .env
.\Scripts\set-mcp-secrets.ps1
```

### 3. Restart Antigravity
Close and reopen Antigravity to load the new skills and workflows.

## 📜 Scripts Reference

| Script | Purpose |
|--------|---------|
| `install-skills.ps1` | Copies skills to `%LOCALAPPDATA%\Google\Antigravity\User Data\User\skills` |
| `install-workflows.ps1` | Copies workflows to `%LOCALAPPDATA%\Google\Antigravity\User Data\User\workflows` |
| `install-rules.ps1` | Copies rules to `~\.gemini\rules` |
| `set-mcp-secrets.ps1` | Sets Docker MCP secrets from `.env` file |
| `setup_lazy_load.ps1` | Enables MCP servers in Docker MCP Gateway |
| `install-mcp-servers.ps1` | Adds MCP server entries to Antigravity config |

All scripts support `-DryRun` to preview changes without making them.

## 🛠️ Included Skills

| Skill | Description |
|-------|-------------|
| `api-builder` | Design and build RESTful/GraphQL APIs |
| `architecture-planner` | Create system architecture diagrams |
| `docker-ops` | Docker container management |
| `git-commit-generator` | Generate conventional commit messages |
| `mcp-manager` | Manage Docker MCP servers efficiently |
| `rule-builder` | Create agent behavioral rules |
| `skill-builder` | Create new AI skills |
| `test-generator` | Generate unit tests (TDD) |
| `tool-creator` | Create custom MCP tools |
| `workflow-builder` | Create agent workflows |

## 🔄 Included Workflows

| Workflow | Slash Command | Description |
|----------|---------------|-------------|
| `/analyze` | Debug mode | Maximum reasoning for problem diagnosis |
| `/architect` | Planning mode | Design new features/systems |
| `/code` | Execution mode | Implement with minimal discussion |
| `/research` | Research mode | Deep web research and analysis |
| `/refactor` | Refactor mode | Safe code refactoring |
| `/tutor` | Learning mode | Generate educational documentation |
| `/tdd` | TDD mode | Test-driven development cycle |

## 🐳 MCP Servers

The `docker-mcp-catalog.yaml` includes these custom servers:

- **Development**: filesystem, github, git, desktop-commander
- **Search**: brave-search, context7, firecrawl
- **Databases**: postgres, mongodb, sqlite, supabase, neon
- **Task Management**: todoist, linear, shrimp-task-manager
- **AI Tools**: memory, sequential-thinking, playwright

### Setting Up MCP

1. Ensure Docker Desktop is running with MCP Toolkit enabled
2. Run `.\Scripts\set-mcp-secrets.ps1` to configure API keys
3. Add the catalog: `docker mcp catalog add mcp-docker-stack local "path\to\docker-mcp-catalog.yaml"`

## 📝 File Format

All skills, workflows, and rules use **Embedded XML in Markdown** format:

```markdown
---
name: component-name
description: |
  Brief description of the component
---

<skill name="component-name" version="1.0.0">
  <goal>What this component does</goal>
  
  <workflow>
    <step number="1" name="Step Name">
      <instruction>What to do</instruction>
    </step>
  </workflow>
</skill>
```

This format provides:
- **YAML frontmatter** for discovery and metadata
- **XML body** for structured, parseable instructions

## 🔐 Environment Variables

Copy `example.env` to `.env` and fill in your credentials:

| Variable | Service |
|----------|---------|
| `GITHUB_PERSONAL_ACCESS_TOKEN` | GitHub API access |
| `BRAVE_API_KEY` | Brave Search API |
| `POSTGRES_URL` | PostgreSQL connection |
| `SUPABASE_ACCESS_TOKEN` | Supabase management |
| `TAVILY_API_KEY` | Tavily search |
| `FIRECRAWL_API_KEY` | Web scraping |

See `example.env` for the complete list.

## 🔧 Customization

### Adding a New Skill
1. Create folder: `Agent/Skills/my-skill/`
2. Create `SKILL.md` using the embedded XML format
3. Run `.\Scripts\install-skills.ps1`

### Adding a New Workflow
1. Create file: `Agent/Workflows/my-workflow.md`
2. Use embedded XML format with `<workflow>` root
3. Run `.\Scripts\install-workflows.ps1`

### Adding a New Rule
1. Create file: `Agent/Rules/my-rule.md`
2. Use embedded XML format with `<rule>` root
3. Run `.\Scripts\install-rules.ps1`

Use the `skill-builder`, `workflow-builder`, and `rule-builder` skills for guided creation.

## 📄 License

MIT License - feel free to use, modify, and distribute.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

**Built for Google Antigravity** | Supercharge your AI coding assistant
