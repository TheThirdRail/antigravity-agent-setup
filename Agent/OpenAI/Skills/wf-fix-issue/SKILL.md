---
name: wf-fix-issue
description: |
  OpenAI Codex orchestration skill converted from `fix-issue.md`.
  Use when When assigned a GitHub issue; When picking up a bug report; Usage: /fix-issue 123 where 123 is the issue number.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-fix-issue" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, fix-issue, openai, codex</keywords>
    <source_workflow>fix-issue.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-fix-issue</id>
    <name>wf-fix-issue</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Fix a GitHub issue - analyze, implement, test, and create PR</purpose>
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

  <goal>Fix a GitHub issue - analyze, implement, test, and create PR</goal>

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
    <step number="1" name="Fetch Issue Details">
      <instruction>Read the issue description Check comments for additional context Look at any linked issues or PRs</instruction>
    </step>
    <step number="2" name="Create a Branch">
      <instruction>git checkout main git pull git checkout -b fix/issue-$ARGUMENTS</instruction>
      <command>git checkout main</command>
      <command>git pull</command>
      <command>git checkout -b fix/issue-$ARGUMENTS</command>
    </step>
    <step number="3" name="Reproduce the Problem">
      <instruction>Follow the reproduction steps Understand when it happens Note expected vs actual behavior</instruction>
    </step>
    <step number="4" name="Find the Cause">
      <instruction>Search for relevant files Add logging if needed Identify the root cause (not just symptoms)</instruction>
    </step>
    <step number="5" name="Plan the Fix">
      <instruction>What changes are needed? Any side effects to watch for? Keep the fix minimal and focused</instruction>
    </step>
    <step number="6" name="Write a Test">
      <instruction>Use for creating regression test Write a test that fails with the bug This prevents regression later</instruction>
    </step>
    <step number="7" name="Implement the Fix">
      <instruction>Follow existing code style Keep changes minimal Comment non-obvious decisions</instruction>
    </step>
    <step number="8" name="Run Tests">
      <instruction>npm test</instruction>
      <command>npm test</command>
    </step>
    <step number="9" name="Commit with Reference">
      <instruction>Use for conventional commit message git add . git commit -m "fix: [description] Fixes #$ARGUMENTS"</instruction>
      <command>git add .</command>
      <command>git commit -m "fix: [description] Fixes #$ARGUMENTS"</command>
    </step>
    <step number="10" name="Create PR">
      <instruction>Reference the issue in the PR Explain what was wrong and how it was fixed Use /pr workflow if needed</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `git-commit-generator` when that capability is required.</do>
    <do>Invoke related skill `test-generator` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>git-commit-generator</skill>
    <skill>test-generator</skill>
  </related_skills>
</skill>
