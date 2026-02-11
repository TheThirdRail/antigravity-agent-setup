---
name: review
description: |
  Standalone code review for specific files or changes
---

<subagent name="review" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Standalone code review for specific files or changes</purpose>

  <when_to_use>
    <trigger>Request a code review on specific files</trigger>
    <trigger>Review changes before committing</trigger>
    <trigger>Get a second opinion on implementation</trigger>
    <trigger>Pre-merge quality check without full PR workflow</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Focus on code quality, not deployment; Use for targeted review, not full project audits</rule>
  </constraints>

  <workflow>
    <step number="1" name="Identify Scope">
      <action>Ask user which files or folders to review.</action>
      <action>Clarify review focus (security, performance, style, all).</action>
      <action>List of files to review.</action>
    </step>
    <step number="2" name="Run Code Review">
      <action>Use skill `code-reviewer`: Invoke full code review analysis</action>
      <action>Use skill `security-checker`: Include if security focus requested</action>
      <action>Review for: bugs, style, complexity, maintainability.</action>
    </step>
    <step number="3" name="Report Findings">
      <action>Present prioritized list of issues.</action>
      <action>Severity: Critical / High / Medium / Low. For each finding include file, issue description, and suggested fix.</action>
      <action>Offer to fix issues if user approves.</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>All specified files reviewed</criterion>
    <criterion>Issues prioritized by severity</criterion>
    <criterion>Actionable suggestions provided</criterion>
  </output_contract>

  <handoffs>
    <route>/analyze</route>
    <route>/architect</route>
    <route>/code</route>
    <route>/dependency-check</route>
    <route>/deploy</route>
    <route>/fix-issue</route>
    <route>/handoff</route>
    <route>/morning</route>
    <route>/onboard</route>
    <route>/performance-tune</route>
    <route>/pr</route>
    <route>/project-setup</route>
    <route>/refactor</route>
    <route>/research</route>
    <route>/security-audit</route>
    <route>/test-developer</route>
    <route>/tutor</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>

