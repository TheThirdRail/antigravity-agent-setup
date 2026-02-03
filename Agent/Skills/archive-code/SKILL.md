---
name: archive-code
description: |
  Generate SCIP code intelligence indices for precise code navigation.
  Use to create compiler-accurate symbol tables for "Go to definition"
  and "Find references" across projects.
---

# Archive Code Skill

Generate SCIP indices stored in `Agent-Context/Archives/code-index/`.

## Prerequisites

```powershell
# TypeScript/JavaScript
npm install -g @sourcegraph/scip-typescript

# Python (optional)
pip install scip-python
```

## When to Use

- After significant codebase changes
- Before archiving a project for future reference
- When you need precise code navigation data
- Indexing a new project for the first time

## Available Scripts

### Index TypeScript/JavaScript Project

```powershell
.\Agent\Skills\archive-code\scripts\index-ts.ps1 -ProjectPath "D:\Coding\MyProject"
```

### Index Python Project

```powershell
.\Agent\Skills\archive-code\scripts\index-py.ps1 -ProjectPath "D:\Coding\MyPythonProject"
```

### View Index Contents

```powershell
.\Agent\Skills\archive-code\scripts\view-index.ps1 -ProjectName "MyProject"
```

## Output Format

- SCIP indices are binary Protobuf files (`*.scip`)
- Use `scip print --json` to inspect contents
- Each index contains: symbols, references, documentation

## Storage

Indices stored as `Agent-Context/Archives/code-index/{project-name}.scip`
