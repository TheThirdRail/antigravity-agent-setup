---
description: Architect Mode - Plan and design a new feature or project from scratch
---

# Architect Mode Workflow

> **IMPORTANT:** Use MAXIMUM thinking/reasoning depth. Plan thoroughly before any implementation.

## When to Use
- Starting a new project from scratch
- Planning a major new feature
- Designing system architecture

## Workflow Steps

### 1. Clarify Requirements
- Ask questions about scope, requirements, and constraints
- **DO NOT proceed until critical questions are answered**
- Understand the user's vision completely

### 2. Research Best Practices
- Use web search to find current best practices for:
  - The relevant tech stack
  - Project structure conventions
  - Security and performance best practices
- Document findings for reference

### 3. Design Architecture
- Create high-level architecture including:
  - Tech stack decisions
  - File/folder structure
  - Data flow diagrams
  - Dependencies and integration points

### 4. Generate Documentation
Create these files in the project root:

#### `prd.md` - Product Requirements Document
- Goals and objectives
- User stories
- Acceptance criteria
- Technical requirements
- Scope boundaries

#### `checklist.md` - Implementation Checklist
- Phased implementation plan
- Atomic, checkable tasks
- Use `[ ]` for incomplete, `[x]` for complete

#### `project_rules.md` - Project Standards
- Tech stack specifications
- Coding conventions
- Linting rules
- Naming conventions

### 5. Index the Project
If available, use these tools to track the project:
- `mem0` / `memory` - Store architectural decisions
- `codegraph` - Index code relationships
- `ragdocs` - Vector search for docs

### 6. Track Tasks
- Register checklist items with `shrimp-task-manager` (if available)
- Otherwise, use `checklist.md` as the source of truth

## Exit Criteria
- All documentation files created
- User has reviewed and approved the plan
- Ready to transition to `/code` workflow
