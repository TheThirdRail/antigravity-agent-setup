# Script Commands

Quick reference for running all scripts in this folder. These PowerShell scripts configure your Antigravity agent with skills, workflows, rules, and MCP server connections.

---

## ⚠️ Prerequisites

Before running any scripts:

1. **Navigate to the Scripts folder:**

   ```powershell
   cd Scripts
   ```

2. **Ensure your `.env` file is configured:**
   - Copy `example.env` to `.env` in the project root
   - Fill in your API keys (see [`secrets-acquisition-guide.md`](../secrets-acquisition-guide.md))

3. **Docker Desktop must be running** (for MCP-related scripts)

---

## 🧹 Step 1: Clean Up (Optional but Recommended)

Remove deprecated skills, workflows, or rules that are no longer in this repo:

```powershell
.\deprecation-checker.ps1
```

> **What it does:** Scans your global Antigravity folders and removes items that no longer exist in `Agent/`. Prevents stale configurations.

---

## 📦 Step 2: Install Components

These scripts copy components from the repo to Antigravity's global configuration folders:

### Install Rules

```powershell
.\install-rules.ps1
```

> Copies rules to `~\.gemini\rules`

### Install Skills

```powershell
.\install-skills.ps1
```

> Copies skills to `%LOCALAPPDATA%\Google\Antigravity\User Data\User\skills`

### Install Workflows

```powershell
.\install-workflows.ps1
```

> Copies workflows to `%LOCALAPPDATA%\Google\Antigravity\User Data\User\workflows`

### Install MCP Server Configurations

```powershell
.\install-mcp-servers.ps1
```

> Configure MCP servers in Antigravity's settings

---

## 🔐 Step 3: Configure Secrets

These scripts set up your API keys and MCP server connections:

### Set MCP Secrets

```powershell
.\set-mcp-secrets.ps1
```

> Reads your `.env` file and registers secrets with Docker MCP Gateway

### Enable Lazy Loading

```powershell
.\setup_lazy_load.ps1
```

> Configures MCP servers to load on-demand (saves resources)

---

## 🔍 Preview Mode (Dry Run)

Most scripts support `-DryRun` to preview changes without making them:

```powershell
# See what would be installed
.\install-rules.ps1 -DryRun
.\install-skills.ps1 -DryRun
.\install-workflows.ps1 -DryRun

# See what would be deprecated
.\deprecation-checker.ps1 -DryRun
```

---

## 🚀 Full Sync (Recommended Order)

Run all scripts in sequence for a complete setup:

```powershell
# 1. Remove deprecated items first
.\deprecation-checker.ps1

# 2. Install fresh copies
.\install-rules.ps1
.\install-skills.ps1
.\install-workflows.ps1
.\install-mcp-servers.ps1

# 3. Configure secrets and lazy loading
.\set-mcp-secrets.ps1
.\setup_lazy_load.ps1
```

After running all scripts, **restart Antigravity** to load the changes.

---

## ❓ Troubleshooting

| Problem | Solution |
|---------|----------|
| "Script cannot be loaded" | Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| ".env file not found" | Make sure you copied `example.env` to `.env` in the project root |
| Docker errors | Ensure Docker Desktop is running with MCP Toolkit enabled |
| Scripts do nothing | Run with `-DryRun` first, then without it to actually apply changes |
