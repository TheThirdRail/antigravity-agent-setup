---
name: wf-architect
description: |
  OpenAI Codex orchestration skill converted from `architect.md`.
  Use when User says "I have an idea"; User says "Help me plan"; Ambiguous requirements needing clarification.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-architect" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, architect, openai, codex</keywords>
    <source_workflow>architect.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-architect</id>
    <name>wf-architect</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Architect Mode - Plan and design a new feature or project from scratch</purpose>
    <inputs>
      <input>User request and relevant project context.</input>
    </inputs>
    <outputs>
      <output>Completed guidance, actions, or artifacts produced by this skill.</output>
    </outputs>
    <triggers>
      <trigger>Use when the frontmatter description conditions are met.</trigger>
    </triggers>
    <procedure>Follow the ordered steps in the workflow section.</procedure>
    <edge_cases>
      <edge_case>If required context is missing, gather or request it before continuing.</edge_case>
    </edge_cases>
    <safety_constraints>
      <constraint>Avoid destructive operations without explicit user intent.</constraint>
    </safety_constraints>
    <examples>
      <example>Activate this skill when the request matches its trigger conditions.</example>
    </examples>
  </spec_contract>

  <goal>Architect Mode - Plan and design a new feature or project from scratch</goal>

  <core_principles>
    <principle name="Orchestrate First">
      <rule>Act as an orchestration skill: sequence actions, call specialized skills, and keep task focus.</rule>
    </principle>
    <principle name="Deterministic Flow">
      <rule>Follow the ordered step flow from the source workflow unless constraints require adaptation.</rule>
    </principle>
    <principle name="Validation Before Completion">
      <rule>Require verification checks before marking the workflow complete.</rule>
    </principle>
    <principle name="Source Constraints">
      <rule>DO NOT write implementation code (use /code workflow for that)</rule>
      <rule>DO NOT create source files (only config, docs, and scaffolding)</rule>
      <rule>Focus ONLY on planning, structure, and documentation</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Clarify Vision">
      <instruction>Ask open-ended questions to understand the "What" and "Why". Identify the user's ultimate goal and success criteria. "What problem are we solving?" "Who is this for?" Agree on the "MVP" (Minimum Viable Product) features. Determine techni...</instruction>
    </step>
    <step number="2" name="Clarify Requirements">
      <instruction>Ask questions about scope, requirements, and constraints DO NOT proceed until critical questions are answered Understand the user's vision completely</instruction>
    </step>
    <step number="3" name="Research Best Practices">
      <instruction>Use this skill for contextual information gathering Research current best practices for the relevant tech stack Research project structure conventions Research security and performance best practices Document findings for reference</instruction>
    </step>
    <step number="4" name="Design Architecture">
      <instruction>Use this skill for diagrams and ADRs Use this skill for UI/UX and component design Use this skill for API, database, and security design Create high-level architecture including tech stack decisions Define file/folder structure Create da...</instruction>
    </step>
    <step number="5" name="Generate Documentation">
      <instruction>Goals, user stories, acceptance criteria, technical requirements, scope Phased implementation plan with atomic, checkable tasks Tech stack, coding conventions, linting rules, naming conventions</instruction>
    </step>
    <step number="6" name="Index the Project">
      <instruction>Store architectural decisions Index code relationships Vector search for docs</instruction>
    </step>
    <step number="7" name="Track Tasks">
      <instruction>Register checklist items with task manager if available Otherwise, use checklist.md as the source of truth</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `architecture-planner` when that capability is required.</do>
    <do>Invoke related skill `backend-architect` when that capability is required.</do>
    <do>Invoke related skill `frontend-architect` when that capability is required.</do>
    <do>Invoke related skill `research-capability` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>architecture-planner</skill>
    <skill>backend-architect</skill>
    <skill>frontend-architect</skill>
    <skill>research-capability</skill>
  </related_skills>
</skill>
