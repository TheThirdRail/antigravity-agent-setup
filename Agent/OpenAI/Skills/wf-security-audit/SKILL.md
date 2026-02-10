---
name: wf-security-audit
description: |
  OpenAI Codex orchestration skill converted from `security-audit.md`.
  Use when Before releasing to production; After adding authentication or payment features; Regular monthly security check.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-security-audit" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, security-audit, openai, codex, security</keywords>
    <source_workflow>security-audit.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-security-audit</id>
    <name>wf-security-audit</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Scan codebase for security vulnerabilities, exposed secrets, and risky patterns</purpose>
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

  <goal>Scan codebase for security vulnerabilities, exposed secrets, and risky patterns</goal>

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
    <step number="1" name="Run Security Checker Skill">
      <instruction>Invoke full security analysis The skill handles: secret scanning, injection checks, auth review, input validation. Review the skill's prioritized findings before proceeding.</instruction>
    </step>
    <step number="2" name="Check Dependencies">
      <instruction>npm audit pip-audit Run appropriate command based on project type.</instruction>
      <command>npm audit</command>
      <command>pip-audit</command>
    </step>
    <step number="3" name="Generate Report">
      <instruction>Compile findings from skill and dependency audit. Prioritize by severity (Critical → High → Medium → Low). Suggest fixes for each issue. Security audit report with prioritized issues and remediation steps.</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `security-checker` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>security-checker</skill>
  </related_skills>
</skill>
