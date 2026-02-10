---
name: wf-morning
description: |
  OpenAI Codex orchestration skill converted from `morning.md`.
  Use when Start of each work day; After being away from the project; When returning to a project after a break.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-morning" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, morning, openai, codex</keywords>
    <source_workflow>morning.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-morning</id>
    <name>wf-morning</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Daily startup routine - sync code, check status, prepare for work</purpose>
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

  <goal>Daily startup routine - sync code, check status, prepare for work</goal>

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
    <step number="1" name="Sync with Remote">
      <instruction>git fetch --all git pull</instruction>
      <command>git fetch --all</command>
      <command>git pull</command>
    </step>
    <step number="2" name="Check Branch Status">
      <instruction>git status git branch -v</instruction>
      <command>git status</command>
      <command>git branch -v</command>
    </step>
    <step number="3" name="Install Dependencies">
      <instruction>npm install</instruction>
      <command>npm install</command>
    </step>
    <step number="4" name="Run Tests">
      <instruction>npm test</instruction>
      <command>npm test</command>
    </step>
    <step number="5" name="Check for Stashed Work">
      <instruction>git stash list</instruction>
      <command>git stash list</command>
    </step>
    <step number="6" name="Review TODO/Handoff">
      <instruction>Read HANDOFF.md if it exists Check issue tracker Review any notes from yesterday</instruction>
    </step>
    <step number="7" name="Plan the Day">
      <instruction>Pick 1-3 priorities Estimate time needed Identify any blockers</instruction>
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
