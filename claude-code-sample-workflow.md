# Claude Code Sample Workflow Guide

## Rules Outline (Read This First)

This section summarizes the Anthropic Claude Code policy and routing setup used in this repository.

### 1) Core Global Rule

Source: `Agent/Anthropic/Rules/CLAUDE.md`

Key expectations:

- define user intent before implementation
- act with autonomy unless ambiguity changes outcomes
- read files before modifying
- keep secure defaults and clear error handling
- update docs/tests when behavior changes
- define unfamiliar terms in plain language on first mention

### 2) Routing Rule

Source: `Agent/Anthropic/Rules/routing-tooling-rules.md`

Route by intent to Anthropic subagents. Examples:

- planning -> `/architect`
- implementation -> `/code`
- debugging -> `/analyze`
- security -> `/security-audit`
- review -> `/review`

Tutor behavior:

- `/tutor` is used only when the user explicitly asks for extra learning support.

### 3) Governance + Archive Rule

Source: `Agent/Anthropic/Rules/governance-context-rules.md`

Archive policy is event-driven and aligned with other vendors:

- setup
- planning
- research
- handoff
- release

Use archive retrieval first when fresh context exists; read source files directly when archive data is stale or missing.

### 4) Runtime Safety + Quality Rules

Sources:

- `Agent/Anthropic/Rules/runtime-safety-rules.md`
- `Agent/Anthropic/Rules/engineering-quality-rules.md`

Before completion:

- meaningful tests should pass
- behavior changes should be documented
- errors/logging must be safe and actionable

## Example 1: Start the Day with Context

What to type:

```text
/morning Summarize branch state, tests, blockers, and top 3 priorities.
```

What happens:

1. Current repo state is reviewed.
2. Priority work is surfaced.
3. You get a short, actionable daily plan.

## Example 2: Plan Then Implement

### Step A: Plan

```text
/architect I want to add a beginner setup checker with clear troubleshooting messages.
```

Expected output:

- clarified scope
- architecture direction
- implementation checklist

### Step B: Implement

```text
/code Implement checklist items 1-3 with tests and docs updates.
```

Expected output:

- targeted code changes
- verification summary
- concise explanation of non-obvious decisions

## Example 3: Diagnose Then Fix

```text
/analyze Install script fails with \"source folder not found\" on Windows.
```

Then:

```text
/fix-issue Apply a minimal patch and verify.
```

Expected result:

- root cause identified first
- smallest safe fix applied
- verification evidence returned

## Example 4: Pre-merge Quality and Security

Run in order:

```text
/review Check changed files and prioritize findings.
/test-developer Add missing tests for changed behavior.
/security-audit Scan for secrets, unsafe patterns, and dependency risks.
/pr Prepare PR summary with what/why/how and verification notes.
```

## Example 5: Use Archive Skills for Context

```text
Use archive-manager to retrieve prior decisions about installer destinations and archive policy.
```

Potential routed skills:

- `archive-memory`
- `archive-docs`
- `archive-graph`
- `archive-git`
- `archive-code`

## Example 6: Ask for Teaching Support Explicitly

```text
/tutor Explain how subagents differ from workflows in this repo using non-technical language first.
```

Use this when you want deeper explanations; normal implementation flows should not auto-switch to tutor mode.

## Suggested Working Routine

1. Use `/morning` to get current state.
2. Use `/architect` before large changes.
3. Use `/code` for implementation.
4. Use `/review` + `/test-developer` + `/security-audit` before merge.
5. Use `/handoff` at the end of the session.

## Quick Prompt Library

```text
/architect Plan this feature and return acceptance criteria.
/code Implement only checklist item 2 with tests.
/analyze Reproduce and rank likely root causes before any edits.
/review List severity-ranked findings with file references.
/security-audit Return prioritized remediation actions.
/tutor Explain this system in beginner-friendly language.
```
