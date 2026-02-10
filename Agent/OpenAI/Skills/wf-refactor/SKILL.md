---
name: wf-refactor
description: |
  OpenAI Codex orchestration skill converted from `refactor.md`.
  Use when refactoring large files/functions, or extracting repeated logic.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-refactor" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, refactor, openai, codex</keywords>
    <source_workflow>refactor.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-refactor</id>
    <name>wf-refactor</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Refactor Mode - Refactor code with full database context to prevent breaking changes</purpose>
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

  <goal>Refactor Mode - Refactor code with full database context to prevent breaking changes</goal>

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
    <step number="1" name="Load Context from Databases">
      <instruction>Query all 3 databases BEFORE making changes: What is this file's purpose? What patterns does this project use? Any documented decisions about this code? What files depend on this one? What functions call the ones I'm changing? What will...</instruction>
    </step>
    <step number="2" name="Identify All References">
      <instruction>Search for all usages across the codebase List all files that import/reference it Identify all call sites Note any external dependencies</instruction>
    </step>
    <step number="3" name="Plan the Refactor">
      <instruction>Use to identify code smells Identify the code smell (why refactor?) Propose strategy before executing Plan for backwards compatibility if needed Estimate risk level</instruction>
    </step>
    <step number="4" name="Execute Incrementally">
      <instruction>For each change: Make ONE logical change Update all call sites Run tests Verify nothing broke Commit or checkpoint</instruction>
    </step>
    <step number="5" name="Update Imports/References">
      <instruction>Fix all import statements Update any configuration files Modify any documentation</instruction>
    </step>
    <step number="6" name="Verify Functionality">
      <instruction>Run all tests Manual verification of affected features Check for regressions</instruction>
    </step>
    <step number="7" name="Update Databases">
      <instruction>After successful refactor, update ALL 3 databases</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `code-reviewer` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>code-reviewer</skill>
  </related_skills>
</skill>
