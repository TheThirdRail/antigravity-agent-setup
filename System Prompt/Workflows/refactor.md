---
description: Refactor Mode - Refactor code with full database context to prevent breaking changes
---

# Refactor Workflow

> **Purpose:** Safely refactor code while maintaining all relationships and updating databases.

## When to Use
- File exceeds 300+ lines (suggest), 500+ (strong), 800+ (blocking)
- Function exceeds 50+ lines (suggest), 100+ (strong)
- Pattern repeated 3+ times (extract to utility)
- Code smell identified
- User requests cleanup

## Workflow Steps

### 1. Load Context from Databases
Query all 3 databases BEFORE making changes:

**From mem0 / memory:**
- What is this file's purpose?
- What patterns does this project use?
- Any documented decisions about this code?

**From codegraph:**
- What files depend on this one?
- What functions call the ones I'm changing?
- What will break if I change this signature?

**From ragdocs:**
- Any documentation about this code?
- Comments explaining non-obvious logic?

### 2. Identify All References
Before modifying ANY function or class:
1. Search for all usages across the codebase
2. List all files that import/reference it
3. Identify all call sites
4. Note any external dependencies

### 3. Plan the Refactor
- Identify the code smell (why refactor?)
- Propose strategy before executing
- Plan for backwards compatibility if needed
- Estimate risk level

### 4. Execute Incrementally
For each change:
1. Make ONE logical change
2. Update all call sites
3. Run tests
4. Verify nothing broke
5. Commit or checkpoint

### 5. Update Imports/References
- Fix all import statements
- Update any configuration files
- Modify any documentation

### 6. Verify Functionality
- Run all tests
- Manual verification of affected features
- Check for regressions

### 7. Update Databases
After successful refactor, update ALL 3 databases:

**mem0 / memory:**
- Update function signatures
- Note what was refactored and why
- Record new file purposes if files were split

**codegraph:**
- Re-index affected files
- Update dependency relationships
- Refresh call graphs

**ragdocs:**
- Update any documentation
- Refresh docstrings/comments

## Refactoring Triggers

| Trigger | Severity | Action |
|---------|----------|--------|
| File > 300 lines | Suggest | Offer to refactor |
| File > 500 lines | Strong | Recommend refactoring |
| File > 800 lines | Blocking | Refuse to add more code |
| Function > 50 lines | Suggest | Offer to break up |
| Function > 100 lines | Strong | Recommend breaking up |
| Pattern 3+ times | Extract | Create utility function |

## Notification Format
When suggesting a refactor:
```
⚠️ REFACTORING RECOMMENDED
• Trigger: [Rule that triggered]
• Location: [File/function]
• Current State: [e.g., "450 lines"]
• Suggested Action: [Proposal]
• Risk Level: [Low/Medium/High]
• Affected Files: [List]
```

## Exit Criteria
- Refactoring complete
- All tests passing
- All references updated
- All 3 databases updated
- No regressions
