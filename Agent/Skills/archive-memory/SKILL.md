---
name: archive-memory
description: |
  Store and retrieve project context in a local SQLite database.
  Use to persist architectural decisions, key patterns, file purposes,
  and other structured memories across sessions.
---

# Archive Memory Skill

Store persistent project context in `Agent-Context/Archives/memory.db`.

## When to Use

- After making architectural decisions
- When documenting key patterns or conventions
- Before ending a session (to preserve context)
- When you need to recall previous decisions

## Available Scripts

### Write Memory

```python
# From project root
python Agent\Skills\archive-memory\scripts\write.py --category "decisions" --key "auth-strategy" --value "JWT with refresh tokens"
```

### Read Memory

```python
# Get specific memory
python Agent\Skills\archive-memory\scripts\read.py --category "decisions" --key "auth-strategy"

# List all in category
python Agent\Skills\archive-memory\scripts\read.py --category "decisions"

# Search across all
python Agent\Skills\archive-memory\scripts\read.py --search "auth"
```

### Delete Memory

```python
python Agent\Skills\archive-memory\scripts\delete.py --category "decisions" --key "auth-strategy"
```

## Categories

- `decisions` - Architectural decisions and rationale
- `patterns` - Code patterns and conventions
- `files` - File purposes and relationships
- `context` - Session context and state
- `custom` - User-defined memories

## Database Schema

```sql
CREATE TABLE memories (
    id INTEGER PRIMARY KEY,
    category TEXT NOT NULL,
    key TEXT NOT NULL,
    value TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(category, key)
);
```
