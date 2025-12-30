---
description: Code Mode - Execute implementation with focus on building, minimal discussion
---

# Code Mode Workflow

> **IMPORTANT:** Planning is complete. Focus 100% on implementation. Minimal discussion, maximum execution.

## When to Use
- After `/architect` workflow is complete and approved
- User says "let's code" or "start implementing"
- Ready to execute on an existing plan

## Prerequisites
- `prd.md` exists (or clear requirements understood)
- `checklist.md` exists (or clear task list)
- Architecture decisions are made

## Workflow Steps

### 1. Load Context
- Read `checklist.md` to understand current progress
- Read `prd.md` for requirements
- Check `project_rules.md` for conventions
- Query memory/codegraph for existing patterns

### 2. Execute Tasks
For each task in the checklist:

1. **Read before write** — Always verify file contents before modifying
2. **Implement** — Write the code
3. **Test** — Verify it works
4. **Update checklist** — Mark task as `[x]` complete

### 3. Code Quality Checks
Before moving to next task:
- [ ] Edge cases handled?
- [ ] Error handling complete?
- [ ] No hardcoded secrets or paths?
- [ ] Types properly defined?
- [ ] Functions do ONE thing?

### 4. Minimize Discussion
- Don't over-explain obvious changes
- Focus on non-obvious logic and decisions
- Keep responses concise
- Only pause for genuine blockers

### 5. Update Progress
- Mark completed tasks in `checklist.md`
- Update memory/codegraph with new functions
- Note any deferred items

## Behavior Rules
- Execute step-by-step from the checklist
- Write code efficiently with minimal preamble
- Test each change before moving on
- Only pause for genuine blockers
- Stay in implementation mode until checklist complete

## Exit Criteria
- All checklist items marked `[x]`
- All tests passing
- Code quality checks complete
- Ready for user review
