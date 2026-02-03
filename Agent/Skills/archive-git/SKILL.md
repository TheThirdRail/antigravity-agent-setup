---
name: archive-git
description: |
  Query git history for semantic code evolution understanding.
  Use to find when features were added, who made changes,
  and how code evolved over time.
---

# Archive Git Skill

Query git history directly (no database needed - uses live git).

## When to Use

- Finding when a feature was introduced
- Understanding why code changed
- Tracking file evolution
- Searching commit history semantically

## Available Scripts

### Search Commits by Message

```powershell
.\Agent\Skills\archive-git\scripts\search.ps1 -RepoPath "D:\Coding\MyProject" -Query "authentication" -Mode "message"
```

### Search Commits by Code Change

```powershell
# Find commits that added/removed specific code
.\Agent\Skills\archive-git\scripts\search.ps1 -RepoPath "D:\Coding\MyProject" -Query "JWT_SECRET" -Mode "diff"
```

### Get File History

```powershell
.\Agent\Skills\archive-git\scripts\file-history.ps1 -RepoPath "D:\Coding\MyProject" -FilePath "src/auth/login.ts" -Limit 10
```

### Get Recent Activity

```powershell
.\Agent\Skills\archive-git\scripts\recent.ps1 -RepoPath "D:\Coding\MyProject" -Days 7
```

## Output Format

Results include: commit hash, date, author, message, and optionally diff stats.

## Notes

- Uses live git queries (always current)
- No caching (results are real-time)
- Requires git to be installed and in PATH
