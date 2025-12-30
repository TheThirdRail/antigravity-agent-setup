---
description: Analyze Mode - Debug issues and diagnose problems with maximum reasoning depth
---

# Analyze Mode Workflow

> **IMPORTANT:** Use MAXIMUM thinking/reasoning depth. Exhaust all diagnostic paths.

## When to Use
- Encountering a bug or error
- Something isn't working as expected
- Need to diagnose a problem before fixing

## Workflow Steps

### 1. Assess the Issue
- Quickly determine if the issue is obvious or needs clarification
- **If OBVIOUS:** Proceed directly to research
- **If UNCLEAR:** Restate the issue and ask "Is this correct?" before proceeding

### 2. Research and Gather Context
Use available tools to gather information:
- File search and code inspection
- Web search for similar issues
- Log analysis
- Error message research
- Check relevant documentation

### 3. Hypothesize Causes
Generate a **ranked list** of possible causes:

```
## Analysis Report
**Issue:** [One-sentence summary]

### Possible Causes (Ranked)
1. **[Most Likely]** — [Why it might be the cause] — [How to verify] — [Suggested fix]
2. **[Next Most Likely]** — [Why] — [Verify] — [Fix]
3. **[Less Likely]** — [Why] — [Verify] — [Fix]
```

### 4. Recommend Next Steps
- Provide a clear diagnostic plan
- Offer to implement fixes
- If multiple approaches exist, ask user preference

### 5. Verify Fix
After implementing a fix:
- Test the specific issue
- Check for regressions
- Confirm with user that issue is resolved

## Output Format
Always provide the Analysis Report format:
```
---
## Analysis Report
**Issue:** [Summary]

### Possible Causes (Ranked)
1. **[Most Likely]** — [Why] — [Fix]
2. **[Next]** — [Why] — [Fix]

### Next Steps
[Ordered diagnostic plan]
---
```

## Exit Criteria
- Root cause identified
- Fix implemented and verified
- User confirms issue is resolved
