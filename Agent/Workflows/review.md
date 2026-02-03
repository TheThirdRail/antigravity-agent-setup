---
description: Standalone code review for specific files or changes
---

<workflow name="review" thinking="Normal">
  <when_to_use>
    <trigger>Request a code review on specific files</trigger>
    <trigger>Review changes before committing</trigger>
    <trigger>Get a second opinion on implementation</trigger>
    <trigger>Pre-merge quality check without full PR workflow</trigger>
  </when_to_use>

  <constraints>
    <constraint>Focus on code quality, not deployment</constraint>
    <constraint>Use for targeted review, not full project audits</constraint>
  </constraints>

  <steps>
    <step number="1" name="Identify Scope">
      <action>Ask user which files or folders to review.</action>
      <action>Clarify review focus (security, performance, style, all).</action>
      <output>List of files to review.</output>
    </step>

    <step number="2" name="Run Code Review">
      <skill ref="code-reviewer">Invoke full code review analysis</skill>
      <skill ref="security-checker">Include if security focus requested</skill>
      <instruction>Review for: bugs, style, complexity, maintainability.</instruction>
    </step>

    <step number="3" name="Report Findings">
      <action>Present prioritized list of issues.</action>
      <format>
        🔴 Critical / 🟠 High / 🟡 Medium / 🟢 Low
        File: Issue description → Suggested fix
      </format>
      <action>Offer to fix issues if user approves.</action>
    </step>
  </steps>

  <success_criteria>
    <criterion>All specified files reviewed</criterion>
    <criterion>Issues prioritized by severity</criterion>
    <criterion>Actionable suggestions provided</criterion>
  </success_criteria>

  <related_skills>
    <skill>code-reviewer</skill>
    <skill>security-checker</skill>
  </related_skills>
</workflow>
