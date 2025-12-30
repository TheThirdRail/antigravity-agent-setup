# MCP Server Diagnostics

**Generated:** 2025-12-30  
**Total Servers:** 33 (enabled)  
**Status:** ✅ All systems operational

---

## 📊 Server Overview by Category

### Core Development

| Server | Description | Tools |
|--------|-------------|-------|
| **filesystem** | File system operations on D:/Coding | `read_file`, `read_multiple_files`, `write_file`, `edit_file`, `create_directory`, `list_directory`, `directory_tree`, `move_file`, `search_files`, `get_file_info`, `list_allowed_directories` |
| **git** | Git version control operations | `git_status`, `git_diff_staged`, `git_commit`, `git_add`, `git_reset`, `git_log`, `git_create_branch`, `git_checkout`, `git_show`, `git_init`, `git_clone`, `git_diff_unstaged`, `git_diff`, `git_list_branches` |
| **github** | GitHub API integration (Archived) | `create_or_update_file`, `create_issue`, `create_pull_request`, `create_repository`, `fork_repository`, `get_file_contents`, `list_issues`, `push_files`, `search_code`, `search_issues`, `search_users` |
| **github-official** | Official GitHub MCP (Full API) | Full GitHub API access including Issues, PRs, Discussions, Actions, Projects |
| **gitmcp** | Convert GitHub repos to markdown | `convert_repo`, `get_context` |

---

### Language Servers & Code Intelligence

| Server | Description | Tools |
|--------|-------------|-------|
| **lsmcp** | TypeScript/JavaScript LSP | `get_diagnostics`, `get_hover`, `get_definition`, `get_references`, `get_completions`, `get_document_symbols`, `get_workspace_symbols` |
| **pylance** | Python language server | `get_diagnostics`, `get_hover`, `get_definition`, `get_references`, `get_completions` |
| **rust-analyzer** | Rust language server | `get_diagnostics`, `get_hover`, `get_definition`, `get_references`, `analyze_code` |
| **clangd** | C/C++ language server | `get_diagnostics`, `get_hover`, `get_definition`, `get_references` |
| **serena** | AI-powered code understanding | `analyze`, `explain_code`, `suggest_improvements` |
| **context7** | Advanced codebase context | `get_library_docs`, `resolve_library_id` |
| **codegraph** | Code graph visualization | `index_codebase`, `query_graph`, `visualize` |
| **vscode-mcp** | VS Code workspace access | `read_workspace`, `get_diagnostics`, `edit_file` |

---

### Command Execution

| Server | Description | Tools |
|--------|-------------|-------|
| **desktop-commander** | Secure terminal execution | `execute_command`, `read_output`, `list_processes`, `kill_process` |

---

### AI Reasoning & Memory

| Server | Description | Tools |
|--------|-------------|-------|
| **sequential-thinking** | Step-by-step reasoning | `create_sequential_thinking_session` |
| **memory** | Persistent memory across sessions | `store`, `retrieve`, `search`, `delete` |
| **mem0** | Semantic memory for coding | `add_memory`, `search_memories`, `get_memories` |

---

### Task Management

| Server | Description | Tools |
|--------|-------------|-------|
| **shrimp-task-manager** | Local task management (Free) | `add_task`, `list_tasks`, `update_task`, `complete_task`, `clear_tasks` |
| **todoist** | Todoist integration | `get_tasks`, `create_task`, `update_task`, `delete_task`, `get_projects` |
| **linear** | Linear project management | `get_issues`, `create_issue`, `update_issue`, `get_projects` |

---

### Search & Research

| Server | Description | Tools |
|--------|-------------|-------|
| **searxng** | Self-hosted meta-search | `search`, `search_code`, `search_stackoverflow`, `search_github`, `search_images` |
| **brave-search** | Brave Search API | `brave_search`, `brave_web_search` |
| **tavily** | AI-optimized search (1000/mo free) | `search`, `search_context`, `qna_search` |
| **firecrawl** | Web scraping for LLMs | `scrape`, `crawl`, `map_site` |
| **fetch** | URL to markdown converter | `fetch_url` |
| **arxiv** | Academic paper search | `search_papers`, `get_paper` |
| **pubmed** | Medical/science paper search | `search_pubmed`, `get_article` |

---

### Knowledge Management

| Server | Description | Tools |
|--------|-------------|-------|
| **notion** | Notion workspace integration | `search_pages`, `get_page`, `create_page`, `update_page` |
| **obsidian** | Obsidian vault access | `read_note`, `write_note`, `search_vault`, `list_notes` |
| **ragdocs** | Documentation vector search | `add_docs`, `search_docs`, `query` |

---

### Databases - SQL

| Server | Description | Tools |
|--------|-------------|-------|
| **postgres** | PostgreSQL operations | `query`, `execute`, `describe_table`, `list_tables` |
| **sqlite** | SQLite operations | `query`, `execute`, `describe_table` |
| **supabase** | Supabase platform | `execute_sql`, `get_projects`, `manage_tables` |
| **neon** | Neon serverless Postgres | `query`, `create_database`, `list_databases` |

---

### Databases - NoSQL

| Server | Description | Tools |
|--------|-------------|-------|
| **mongodb** | MongoDB operations | `find`, `insert`, `update`, `delete`, `aggregate` |

---

### Infrastructure & Deployment

| Server | Description | Tools |
|--------|-------------|-------|
| **docker-mcp** | Docker container management | `list_containers`, `run_container`, `stop_container`, `build_image` |
| **cloudflare** | Cloudflare Workers and CDN | `list_workers`, `deploy_worker`, `manage_kv` |

---

### Security & Testing

| Server | Description | Tools |
|--------|-------------|-------|
| **snyk** | Vulnerability scanning | `test_project`, `get_vulnerabilities` |
| **gitguardian** | Secret detection | `scan_secrets`, `get_incidents` |
| **semgrep** | SAST code scanning | `scan`, `scan_directory`, `get_rules` |
| **playwright** | Browser automation & E2E | `navigate`, `click`, `type`, `screenshot`, `evaluate` |

---

### Orchestration

| Server | Description | Tools |
|--------|-------------|-------|
| **compass** | MCP server orchestration | `list_servers`, `call_server`, `manage_routing` |

---

### Frontend Development

| Server | Description | Tools |
|--------|-------------|-------|
| **react-mcp** | React project manipulation | `create_component`, `modify_component`, `analyze_project` |
| **vue-mcp** | Vue.js development | `access_component_tree`, `get_state`, `manage_pinia` |
| **shadcn-vue** | shadcn/ui components | `install_component`, `list_components` |
| **magic-mcp** | UI component generation | `generate_ui`, `create_component` |
| **augments** | 90+ framework docs | `get_docs`, `search_docs`, `list_frameworks` |
| **package-registry** | NPM/PyPi/Cargo search | `search_packages`, `get_package_info` |

---

## 📁 Project Structure After Cleanup

```
mcp-docker-stack/
├── Archive/                    # Old/deprecated files
│   ├── bootstrap-example.yaml
│   ├── docker-compose.txt
│   ├── docker-compose.yml,BROKEN
│   ├── mcp-server-list.txt
│   ├── ncp.config.json
│   ├── server_list_full.txt
│   └── tools_list.txt
├── Knowledge/                  # Documentation
│   ├── ADDITIONAL_MCP_SERVERS.md
│   ├── DOCKER_DESKTOP_UI_GUIDE.md
│   ├── SECRETS_AND_CONFIG_GUIDE.md
│   └── setup_instructions.md
├── SearXNG/                    # Custom SearXNG server
│   ├── package.json
│   └── searxng-mcp.js
├── System Prompt/              # AI system instructions
│   └── system_instructions.xml
├── .env                        # Secrets (DO NOT COMMIT)
├── .gitignore
├── docker-compose.yml
├── docker-mcp-catalog.yaml     # Main catalog file
├── example.env                 # Template for .env
├── MCP-Diagnostics.md          # This file
└── set-mcp-secrets.ps1         # Secrets configuration script
```

---

## ✅ Verification Checklist

- [x] Docker cleaned (34.53GB reclaimed)
- [x] 33 MCP servers enabled
- [x] Secrets configured via `set-mcp-secrets.ps1`
- [x] YAML syntax fixed (5 `&&` errors corrected)
- [x] Files reorganized into Archive/Knowledge/System Prompt
- [x] Kubernetes removed (not needed for local dev)
- [x] Perplexity Nexus removed (not free after $5)
- [x] New servers added: Semgrep, GitMCP, GitHub Official, Fetch

---

## 🚀 Quick Commands

```powershell
# List all servers
docker mcp server ls

# Check secrets
docker mcp secret ls

# Reimport catalog after changes
docker mcp catalog import ./docker-mcp-catalog.yaml

# Set secrets after updating .env
./set-mcp-secrets.ps1
```
