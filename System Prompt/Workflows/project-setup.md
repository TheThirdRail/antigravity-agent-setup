---
description: Project Setup - Initialize project structure after Architect Mode planning
---

# Project Setup Workflow

> **Purpose:** Initialize project structure AFTER `/architect` planning is complete.

## When to Use
- After `/architect` has created prd.md, checklist.md
- Before starting `/code` implementation
- To set up file structure and configuration

## Prerequisites
- `/architect` workflow MUST be completed first
- `prd.md` and `checklist.md` should exist
- Project requirements are clear

## Workflow Steps

### 1. Create .gitignore
Create a comprehensive `.gitignore` file:

```gitignore
# Dependencies
node_modules/
vendor/
.venv/
__pycache__/
*.pyc
*.pyo

# Build outputs
dist/
build/
out/
.next/

# IDE
.idea/
.vscode/settings.json
*.swp
*.swo

# Environment
.env
.env.local
.env.*.local
*.local

# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# OS
.DS_Store
Thumbs.db

# AI/Agent Generated Folders (DO NOT COMMIT)
education/
research/

# Testing
coverage/
.nyc_output/
*.lcov

# Temporary
tmp/
temp/
*.tmp
```

### 2. Create Project Structure
Based on the tech stack from `/architect`:

**Ask user which structure to use, or infer from prd.md:**

**For Web/Node Projects:**
```
src/
  components/
  pages/
  utils/
  styles/
public/
tests/
docs/
```

**For Python Projects:**
```
src/
  __init__.py
  main.py
tests/
docs/
scripts/
```

### 3. Generate project_rules.md
Create `project_rules.md` with project-specific standards:

```markdown
# Project Rules

## Tech Stack
- [Framework/Language from prd.md]
- [Database if applicable]
- [Key libraries]

## Coding Conventions
- [Naming conventions]
- [File organization]
- [Import ordering]

## Linting & Formatting
- [ESLint/Prettier/Black/etc.]
- [Configuration notes]

## Git Workflow
- [Branch naming]
- [Commit message format]
- [PR process]

## Testing Requirements
- [Test framework]
- [Coverage requirements]
- [Test file naming]
```

### 4. Initialize Git (if requested)
```bash
git init
git add .
git commit -m "Initial project setup"
```

### 5. Create README.md
Generate README with:
- Project name and description (from prd.md)
- Installation instructions
- Usage examples
- Contributing guidelines

### 6. Prepare for Implementation
Inform user that project is ready:
- All structure created
- Rules defined
- Ready for `/code` workflow

## Files Created
- `.gitignore` (includes `education/` and `research/`)
- `project_rules.md`
- `README.md`
- Basic folder structure
- (Optional) `git init`

## Exit Criteria
- All configuration files created
- Folder structure matches architecture
- Ready to proceed with `/code`
