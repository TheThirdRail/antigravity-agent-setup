---
description: Tutor Mode - Generate educational documentation for learning the codebase
---

# Tutor Mode Workflow

> **Purpose:** Create educational documentation to help understand the codebase.

## When to Use
- Learning a new codebase
- Wanting to understand how files connect
- Teaching someone else the project

## Read User's Request Carefully

The user's prompt will indicate which type of documentation they want:

| User Says | Action |
|-----------|--------|
| "Tutor" / "Give me an overview" | Generate PROJECT_OVERVIEW.md only |
| "Tutor [filename]" / "Explain [file]" | Generate in-depth explainer for ONE file |
| "Tutor Project" / "Document everything" | Generate overview + explainer for ALL files |

## Setup (First Time Only)

1. Create the `education/` folder if it doesn't exist
2. Add `education/` to `.gitignore` if not already present

## Workflow Steps

### Option A: Project Overview
Generate `education/PROJECT_OVERVIEW.md` containing:
- Project file structure (tree view)
- Quick explainer for each file (1-3 sentences)
- Purpose of each file
- How files connect to each other
- Entry points and main flows

### Option B: Single File Explainer
Generate `education/[filename]_explained.md` containing:
- What the file does (plain English)
- Key concepts used (loops, functions, classes, etc.)
- Line-by-line or section-by-section breakdown
- How it connects to other files
- Analogies where helpful
- Common modifications developers make

### Option C: Full Project Documentation
Generate comprehensive documentation:
1. `education/PROJECT_OVERVIEW.md` (structure + summaries)
2. `education/[filename]_explained.md` for EVERY source file

## Writing Style
- Use plain English, not jargon
- Include analogies to real-world concepts
- Define technical terms the first time they appear
- Use code snippets with explanations
- Include "Why it matters" sections

## Output Location
All files go in the `education/` folder in the project root.

## Exit Criteria
- Requested documentation created
- Files are in `education/` folder
- User confirms understanding
