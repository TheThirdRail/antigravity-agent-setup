---
name: archive-graph
description: |
  Build and query a comprehensive knowledge graph of the codebase using Tree-sitter and SQLite.
  Enables understanding of relationships between functions, classes, and files.
---

# Archive Graph Skill

Store structured code relationships in `Agent-Context/Archives/graph.db`.

## Prerequisites

```powershell
pip install tree-sitter tree-sitter-languages
```

## When to Use

- Understanding project architecture and dependencies
- Finding callers/callees of functions locally
- analyzing impact of changes (graph traversal)
- "Find all functions that use X"

## Available Scripts

### Build Graph

```powershell
# Index a project directory
python Agent\Skills\archive-graph\scripts\build.py --path "D:\Coding\MyProject"
```

### Query Graph

```powershell
# Find dependencies of a function
python Agent\Skills\archive-graph\scripts\query.py --query "MATCH (f:function)-[:calls]->(d) WHERE f.name='login' RETURN d"

# Find structural path
python Agent\Skills\archive-graph\scripts\query.py --start "login" --end "Database" --depth 3
```

## Database Schema

- **Nodes**: `id`, `type` (function, class, file), `name`, `path`, `start_line`, `end_line`
- **Edges**: `source_id`, `target_id`, `type` (defines, calls, imports, inherits)

## Details

- Uses `tree-sitter-languages` for robust, multi-language parsing
- Stores everything in a portable SQLite file
- Supports recursive graph queries via CTEs
