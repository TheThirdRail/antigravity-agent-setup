---
name: wf-pr
description: |
  OpenAI Codex orchestration skill converted from `pr.md`.
  Use when When code is ready for review; When a feature or fix is complete; Before merging to main branch.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-pr" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, pr, openai, codex</keywords>
    <source_workflow>pr.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-pr</id>
    <name>wf-pr</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Create a pull request with proper description, tests verified, and ready for review</purpose>
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

  <goal>Create a pull request with proper description, tests verified, and ready for review</goal>

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
    <step number="1" name="Verify Tests Pass">
      <instruction>npm test</instruction>
      <command>npm test</command>
    </step>
    <step number="2" name="Run Linter">
      <instruction>npm run lint</instruction>
      <command>npm run lint</command>
    </step>
    <step number="3" name="Check What's Changed">
      <instruction>git diff main --stat</instruction>
      <command>git diff main --stat</command>
    </step>
    <step number="4" name="Clean Up Commits">
      <instruction>Combine "WIP" commits Write clear commit messages Each commit should be meaningful</instruction>
    </step>
    <step number="5" name="Push Branch">
      <instruction>git push -u origin HEAD</instruction>
      <command>git push -u origin HEAD</command>
    </step>
    <step number="6" name="Generate PR Description">
      <instruction>## What [Brief description of what this PR does] ## Why [Why this change is needed - link to issue if applicable] ## How [How the change works, key implementation details] ## Testing - [ ] Unit tests added/updated - [ ] Manual testing co...</instruction>
    </step>
    <step number="7" name="Create the PR">
      <instruction>Use the generated description Add appropriate labels Request reviewers</instruction>
    </step>
    <step number="8" name="Self-Review">
      <instruction>Use for systematic self-review Review the diff in the PR interface Check for accidental debug code Verify no secrets are exposed</instruction>
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
