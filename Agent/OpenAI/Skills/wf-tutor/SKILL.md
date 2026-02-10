---
name: wf-tutor
description: |
  OpenAI Codex orchestration skill converted from `tutor.md`.
  Use when Learning a new codebase; Wanting to understand how files connect; Teaching someone else the project.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-tutor" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, tutor, openai, codex</keywords>
    <source_workflow>tutor.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-tutor</id>
    <name>wf-tutor</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Tutor Mode - Generate educational documentation for learning the codebase</purpose>
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

  <goal>Tutor Mode - Generate educational documentation for learning the codebase</goal>

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
      <rule>DO NOT write implementation code</rule>
      <rule>DO NOT modify source files</rule>
      <rule>Focus ONLY on generating documentation in Agent-Context/Lessons/ folder</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Parse Request Type">
      <instruction>Determine output mode: project overview, single-file explainer, or full-project documentation.</instruction>
    </step>
    <step number="2" name="Prepare Lesson Workspace">
      <instruction>Create Agent-Context/Lessons if missing and ensure generated lesson files are not committed unintentionally.</instruction>
    </step>
    <step number="3" name="Collect Codebase Context">
      <instruction>Map project structure, entry points, and cross-file dependencies before writing explanations.</instruction>
    </step>
    <step number="4" name="Generate Project Overview">
      <instruction>If requested, write PROJECT_OVERVIEW.md with tree view, file purposes, and high-level flow connections.</instruction>
    </step>
    <step number="5" name="Generate File Explainers">
      <instruction>If requested, create [filename]_explained.md files with section-by-section explanations and practical modification guidance.</instruction>
    </step>
    <step number="6" name="Apply Teaching Style Rules">
      <instruction>Use plain language, define technical terms, include short code snippets, and add "why it matters" context.</instruction>
    </step>
    <step number="7" name="Validate Outputs">
      <instruction>Confirm files exist in Agent-Context/Lessons, requested scope is complete, and explanations are understandable.</instruction>
    </step>
    <step number="8" name="Close with Learning Next Steps">
      <instruction>Summarize what was documented and suggest next files or topics to study.</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>documentation-generator</skill>
  </related_skills>
</skill>
