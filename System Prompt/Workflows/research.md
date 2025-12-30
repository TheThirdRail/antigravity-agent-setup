---
description: Research Mode - Deep research with maximum thinking using all search tools
---

# Research Workflow

> **IMPORTANT:** Use MAXIMUM thinking/reasoning depth. Prioritize the most up-to-date sources.

## When to Use
- Researching best practices for a tech stack
- Finding current solutions to technical problems
- Comparing frameworks, libraries, or approaches
- Gathering information before `/architect` mode

## Output Location
All research files go in the `research/` folder:
- Format: `research/[topic]-research.md`
- Example: `research/react-state-management-research.md`

**Note:** The `research/` folder should be in `.gitignore`

## Workflow Steps

### 1. Clarify the Research Topic
Parse the user's request to understand:
- What specific topic to research?
- What decisions need to be made?
- Any constraints (free only, specific language, etc.)?

### 2. Use ALL Available Search Tools
Execute searches using every available tool:

| Tool | Use For |
|------|---------|
| **searxng** | Meta-search across multiple engines |
| **brave-search** | Web search with privacy |
| **tavily** | AI-optimized search |
| **arxiv** | Academic papers (if relevant) |
| **pubmed** | Medical/science (if relevant) |
| **github** | Code examples, popular repos |
| **fetch** | Read specific URLs for deep content |

### 2b. Use Context MCPs for Code Research
When researching code patterns, libraries, or implementations:

| Tool | Use For |
|------|---------|
| **context7** | Get up-to-date library documentation |
| **gitmcp** | Convert GitHub repos to markdown for analysis |
| **augments** | Access 90+ framework documentation sources |
| **lsmcp** | TypeScript/JavaScript code intelligence |
| **pylance** | Python code intelligence |
| **serena** | AI-powered code understanding |
| **codegraph** | Query existing codebase relationships |

**When to use context MCPs:**
- Researching how a library works → Use `context7`
- Analyzing a GitHub repo's structure → Use `gitmcp`
- Finding framework best practices → Use `augments`
- Understanding existing code patterns → Use language servers

### 3. Prioritize Recent Sources
- Prefer sources from 2024-2025
- Note the date of each source
- Flag any outdated information
- Look for "latest" or "current" versions

### 4. Research Areas to Cover

**For Tech Stack Research:**
- Current best practices
- Popular libraries/frameworks
- Performance considerations
- Security recommendations
- Community support/activity
- Learning curve
- Pros and cons

**For Problem-Solving Research:**
- Common solutions
- Edge cases
- Performance implications
- Security considerations
- Real-world examples

### 5. Document Findings
Create `research/[topic]-research.md` with this structure:

```markdown
# [Topic] Research

**Date:** [Today's date]
**Purpose:** [Why this research was needed]

## Executive Summary
[2-3 sentence summary of key findings]

## Key Findings

### Best Practices (2024-2025)
- [Finding 1] — Source: [URL]
- [Finding 2] — Source: [URL]

### Recommended Approach
[Your synthesis and recommendation]

### Alternatives Considered
| Option | Pros | Cons |
|--------|------|------|
| [Option 1] | [Pros] | [Cons] |
| [Option 2] | [Pros] | [Cons] |

### Security Considerations
- [Security note 1]
- [Security note 2]

### Sources
1. [Title](URL) — [Date] — [Brief note]
2. [Title](URL) — [Date] — [Brief note]

## Next Steps
[Recommended actions based on research]
```

### 6. Synthesize and Recommend
- Don't just list findings — synthesize them
- Provide a clear recommendation
- Explain WHY you recommend it
- Note any trade-offs

## Search Strategy

1. **Start broad** — Get an overview of the landscape
2. **Go deep** — Dive into recommended approaches
3. **Verify** — Cross-reference across multiple sources
4. **Check recency** — Ensure information is current
5. **Find examples** — Look for real-world implementations

## Quality Checks
- [ ] Multiple sources consulted?
- [ ] Sources are recent (2024-2025 preferred)?
- [ ] Both pros and cons documented?
- [ ] Clear recommendation provided?
- [ ] File saved to `research/` folder?

## Exit Criteria
- Research file created in `research/` folder
- Clear synthesis and recommendation provided
- Sources documented with dates
- User understands the findings
