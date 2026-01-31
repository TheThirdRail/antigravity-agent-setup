# Antigravity Agent Setup

A comprehensive toolkit for configuring Google Antigravity AI agents with custom skills, workflows, rules, and MCP (Model Context Protocol) servers.

## 🎯 What This Repo Does

This repository provides everything you need to supercharge your Antigravity AI coding assistant:

| Component | Count | Purpose |
|-----------|-------|---------|
| **Skills** | 18 | Reusable AI capabilities (frontend architecture, API building, etc.) |
| **Workflows** | 19 | Step-by-step automation sequences (architect, debug, deploy, etc.) |
| **Rules** | 6 | Behavioral constraints and quality guardrails |
| **MCP Servers** | 40+ | External tools via Docker MCP Gateway (databases, search, security, etc.) |

## 📁 Folder Structure

```
antigravity-agent-setup/
├── Agent/                    # Source files for agent configuration
│   ├── Skills/              # AI skill definitions (XML-in-Markdown)
│   │   └── metadata.schema.json  # JSON Schema for skill discovery
│   ├── Workflows/           # Workflow definitions (XML-in-Markdown)
│   └── Rules/               # Rule definitions (XML-in-Markdown)
├── MCP-Servers/             # Docker MCP server catalog
│   └── mcp-docker-stack/    # Custom MCP server definitions
├── Scripts/                 # PowerShell installation scripts
├── Info/                    # Documentation and guides
│   └── secrets-acquisition-guide.md  # How to get API keys
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
# Edit .env with your actual credentials (see Info/secrets-acquisition-guide.md)
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

All scripts support `-DryRun` to preview changes without making them.

## 🛠️ Included Skills (18)

### Development
| Skill | Description |
|-------|-------------|
| `frontend-architect` | UI component architecture, responsive design, accessibility (WCAG 2.1 AA) |
| `api-builder` | RESTful/GraphQL API design with OpenAPI |
| `architecture-planner` | System architecture diagrams and planning |
| `test-generator` | Unit/integration test generation (TDD) |
| `code-reviewer` | Code review with quality feedback |

### Productivity
| Skill | Description |
|-------|-------------|
| `documentation-generator` | Generate README, ADRs, API docs, changelogs |
| `research-capability` | Information gathering from docs and web |
| `performance-analyzer` | Profiling and optimization patterns |
| `git-commit-generator` | Conventional commit message generation |

### Agent Building
| Skill | Description |
|-------|-------------|
| `skill-builder` | Create new AI skills |
| `workflow-builder` | Create agent workflows |
| `rule-builder` | Create behavioral rules |
| `mcp-builder` | Create MCP server definitions |
| `mcp-manager` | Manage Docker MCP servers |
| `agent-builder` | Build complete agent configurations |

### Infrastructure
| Skill | Description |
|-------|-------------|
| `docker-ops` | Docker container management |
| `ci-cd-debugger` | Debug CI/CD pipelines |
| `security-checker` | Security audit and vulnerability scanning |

## 🔄 Included Workflows (19)

| Mode | Workflow | Description |
|------|----------|-------------|
| **Planning** | `/architect` | Design new features with MAX reasoning |
| **Execution** | `/code` | Implement with minimal discussion |
| **Debugging** | `/analyze` | Deep problem diagnosis |
| **Debugging** | `/debug-step` | Surgical step-by-step debugging |
| **Research** | `/research` | Deep web research and analysis |
| **Learning** | `/tutor` | Generate educational documentation |
| **Testing** | `/test-developer` | Test-driven development cycle |
| **Security** | `/security-audit` | Security vulnerability scanning |
| **Refactoring** | `/refactor` | Safe code refactoring |
| **Deployment** | `/deploy` | Safe production deployment with verification |
| **Performance** | `/performance-tune` | Systematic performance optimization |
| **Onboarding** | `/onboard` | Systematic codebase onboarding |
| **Handoff** | `/handoff` | Session handoff documentation |
| **Daily** | `/morning` | Daily startup routine |
| **PR** | `/pr` | Pull request preparation |
| **Dependencies** | `/dependency-check` | Dependency audit |
| **Issues** | `/fix-issue` | GitHub issue resolution |
| **Project** | `/project-setup` | Initialize new project |
| **Archive** | `/archive` | Index project to databases |

## 🐳 MCP Servers (40+)

The `docker-mcp-catalog.yaml` includes servers across these categories:

### Core Development
- **filesystem**, **github**, **git**, **desktop-commander**, **serena**

### Search & Research
- **brave-search**, **context7**, **firecrawl**, **arxiv**, **pubmed**

### Databases
- **postgres**, **mongodb**, **sqlite**, **supabase**, **neon**, **qdrant** (vector)

### Security (NEW)
- **gitleaks** - Secret detection (500+ patterns, no API key required)
- **sentry** - Error monitoring and observability
- **snyk**, **semgrep** - Vulnerability scanning

### Frontend & Design
- **react**, **vue**, **shadcn**, **magic**

### Task Management
- **todoist**, **linear**, **shrimp-task-manager**

### AI & Memory
- **memory**, **sequential-thinking**, **mem0**

### Setting Up MCP

1. Ensure Docker Desktop is running with MCP Toolkit enabled
2. Get API keys (see `Info/secrets-acquisition-guide.md`)
3. Run `.\Scripts\set-mcp-secrets.ps1` to configure
4. Add catalog: `docker mcp catalog add mcp-docker-stack local "path\to\docker-mcp-catalog.yaml"`

## 📝 File Formats

### Skills, Workflows, Rules (XML-in-Markdown)
```markdown
---
name: component-name
description: Brief description
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

### Skill Metadata (metadata.json)
Optional JSON file for skill discovery:
```json
{
  "name": "frontend-architect",
  "version": "1.0.0",
  "category": "development",
  "keywords": ["frontend", "ui", "react"],
  "triggers": ["build UI component"]
}
```

See `Agent/Skills/metadata.schema.json` for the full schema.

## 🔐 Environment Variables

Copy `example.env` to `.env` and fill in credentials. Key variables:

| Variable | Service | Free Tier |
|----------|---------|-----------|
| `GITHUB_PERSONAL_ACCESS_TOKEN` | GitHub API | ✅ |
| `BRAVE_API_KEY` | Brave Search | ✅ 2k/month |
| `SENTRY_AUTH_TOKEN` | Error monitoring | ✅ 5k events |
| `QDRANT_API_KEY` | Vector database | ✅ 1GB |
| `SUPABASE_ACCESS_TOKEN` | BaaS | ✅ 500MB |

**See `Info/secrets-acquisition-guide.md` for step-by-step instructions to get each API key.**

## 🔧 Customization

### Adding a New Skill
```powershell
# Use the skill-builder
# Or manually:
1. Create folder: Agent/Skills/my-skill/
2. Create SKILL.md (XML-in-Markdown format)
3. Optionally add metadata.json
4. Run .\Scripts\install-skills.ps1
```

### Adding a New Workflow
```powershell
1. Create: Agent/Workflows/my-workflow.md
2. Use <workflow> root element
3. Run .\Scripts\install-workflows.ps1
```

### Adding a New MCP Server
```yaml
# In MCP-Servers/mcp-docker-stack/docker-mcp-catalog.yaml
my-server:
  dateAdded: "2026-01-31T00:00:00Z"
  description: What it does
  title: Display Name
  type: server
  image: node:20-slim
  command: [npx, -y, package-name]
  secrets:
    - name: my-server.key
      env: MY_API_KEY
```

## 📄 License

MIT License - feel free to use, modify, and distribute.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

**Built for Google Antigravity** | Supercharge your AI coding assistant

*Last updated: 2026-01-31*
