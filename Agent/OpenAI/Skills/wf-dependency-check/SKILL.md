---
name: wf-dependency-check
description: |
  OpenAI Codex orchestration skill converted from `dependency-check.md`.
  Use when Monthly maintenance; Before major releases; After security advisories.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-dependency-check" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, dependency-check, openai, codex</keywords>
    <source_workflow>dependency-check.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-dependency-check</id>
    <name>wf-dependency-check</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Check for outdated or vulnerable dependencies and update them safely</purpose>
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

  <goal>Check for outdated or vulnerable dependencies and update them safely</goal>

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
    <step number="1" name="Check for Vulnerabilities">
      <instruction>npm audit</instruction>
      <command>npm audit</command>
    </step>
    <step number="2" name="Check for Outdated Packages">
      <instruction>npm outdated</instruction>
      <command>npm outdated</command>
    </step>
    <step number="3" name="Review the Results">
      <instruction>Update immediately Update soon Update when convenient Review changelog first!</instruction>
    </step>
    <step number="4" name="Update Safe Packages First">
      <instruction>Patch and minor versions npm update</instruction>
      <command>npm update</command>
    </step>
    <step number="5" name="Handle Major Updates Carefully">
      <instruction>Read the changelog/migration guide Update one package Run tests Commit if passing</instruction>
    </step>
    <step number="6" name="Run Full Test Suite">
      <instruction>npm test</instruction>
      <command>npm test</command>
    </step>
    <step number="7" name="Document Changes">
      <instruction>List updated packages Note any breaking changes handled Commit with clear message</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
  </related_skills>
</skill>
