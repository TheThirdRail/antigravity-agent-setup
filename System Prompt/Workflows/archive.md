---
description: Archive Mode - Index the project to databases for AI context preservation
---

# Archive Workflow

> **Purpose:** Archive the current project state to databases for persistent AI context.

## When to Use
- After completing a major feature or milestone
- Before taking a break from the project
- To ensure AI has context in future sessions
- After significant refactoring

## The 3 Databases

| Database | Tool | What It Stores |
|----------|------|----------------|
| **mem0 / memory** | Semantic memory | Function signatures, file purposes, architectural decisions |
| **codegraph** | Graph database | Code relationships, call graphs, dependencies |
| **ragdocs** | Vector database | Documentation, comments, README content |

## Workflow Steps

### 1. Gather Project Information
Collect:
- All source file paths and their purposes
- Key function/class signatures
- Architectural decisions made
- Dependencies and their roles
- Important patterns used

### 2. Archive to mem0 / memory
Store semantic information:
```
- Project name and purpose
- Tech stack used
- Key files and their roles
- Important functions with signatures
- Architectural patterns (e.g., "Uses MVC pattern")
- Non-obvious decisions and WHY they were made
```

### 3. Archive to codegraph
Index code relationships:
```
- File dependency graph
- Function call relationships
- Class inheritance hierarchies
- Import/export maps
- Which files depend on which
```

### 4. Archive to ragdocs
Store searchable documentation:
```
- README content
- Code comments
- Docstrings
- API documentation
- Setup instructions
```

### 5. Verify Archive
- Query each database to confirm data was stored
- Test a sample retrieval
- Note any failures for retry

## What Gets Archived

| Category | Examples |
|----------|----------|
| **Structure** | File tree, folder purposes |
| **Functions** | Name, params, return type, location, purpose |
| **Classes** | Name, methods, relationships |
| **Decisions** | Why X was chosen over Y |
| **Patterns** | Design patterns, conventions used |
| **Dependencies** | What external libs are used and why |

## Exit Criteria
- All 3 databases updated
- Verification queries succeed
- Summary provided to user
