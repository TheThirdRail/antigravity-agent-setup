---
name: wf-review
description: |
  OpenAI Codex orchestration skill converted from `review.md`.
  Use when Request a code review on specific files; Review changes before committing; Get a second opinion on implementation.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-review" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, review, openai, codex</keywords>
    <source_workflow>review.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-review</id>
    <name>wf-review</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Standalone code review for specific files or changes</purpose>
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

  <goal>Standalone code review for specific files or changes</goal>

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
      <rule>Focus on code quality, not deployment</rule>
      <rule>Use for targeted review, not full project audits</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Identify Scope">
      <instruction>Ask user which files or folders to review. Clarify review focus (security, performance, style, all). List of files to review.</instruction>
    </step>
    <step number="2" name="Run Code Review">
      <instruction>Invoke full code review analysis Include if security focus requested Review for: bugs, style, complexity, maintainability.</instruction>
    </step>
    <step number="3" name="Report Findings">
      <instruction>Present prioritized list of issues. 🔴 Critical / 🟠 High / 🟡 Medium / 🟢 Low File: Issue description → Suggested fix Offer to fix issues if user approves.</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `code-reviewer` when that capability is required.</do>
    <do>Invoke related skill `security-checker` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>code-reviewer</skill>
    <skill>security-checker</skill>
  </related_skills>
</skill>
