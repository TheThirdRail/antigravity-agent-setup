---
name: wf-code
description: |
  OpenAI Codex orchestration skill converted from `code.md`.
  Use when After /architect workflow is complete and approved; User says "let's code" or "start implementing"; Ready to execute on an existing plan.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-code" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, code, openai, codex</keywords>
    <source_workflow>code.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-code</id>
    <name>wf-code</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Code with Context - Execute implementation with focus on building, minimal discussion</purpose>
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

  <goal>Code with Context - Execute implementation with focus on building, minimal discussion</goal>

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
  </core_principles>

  <workflow>
    <step number="1" name="Load Context">
      <instruction>Use for API docs and implementation patterns Read checklist.md to understand current progress Read prd.md for requirements Check project_rules.md for conventions Route retrieval through archive-manager and prefer fresh archives before broad source scans</instruction>
    </step>
    <step number="2" name="Execute Tasks">
      <instruction>For each task in the checklist: Read before write — Always verify file contents before modifying Implement — Write the code Test — Verify it works Update checklist — Mark task as [x] complete</instruction>
    </step>
    <step number="3" name="Code Quality Checks">
      <instruction>Use for self-review of changes Edge cases handled? Error handling complete? No hardcoded secrets or paths? Types properly defined? Functions do ONE thing?</instruction>
    </step>
    <step number="4" name="Minimize Discussion">
      <instruction>Don't over-explain obvious changes Focus on non-obvious logic and decisions Keep responses concise Only pause for genuine blockers</instruction>
    </step>
    <step number="5" name="Update Progress">
      <instruction>Mark completed tasks in checklist.md Update memory/codegraph with new functions Run archive-manager to sync archive-code/archive-docs/archive-graph/archive-memory for changed artifacts Note any deferred items</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `code-reviewer` when that capability is required.</do>
    <do>Invoke related skill `research-capability` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>code-reviewer</skill>
    <skill>research-capability</skill>
    <skill>archive-manager</skill>
  </related_skills>
</skill>
