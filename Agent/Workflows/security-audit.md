---
description: Scan codebase for security vulnerabilities, exposed secrets, and risky patterns
---

<workflow name="security-audit" thinking="Normal">
  <when_to_use>
    <trigger>Before releasing to production</trigger>
    <trigger>After adding authentication or payment features</trigger>
    <trigger>Regular monthly security check</trigger>
  </when_to_use>

  <recommended_mcp>
    <server>snyk</server>
    <reason>Automated vulnerability scanning</reason>
  </recommended_mcp>

  <steps>
    <step number="1" name="Run Security Checker Skill">
      <skill ref="security-checker">Invoke full security analysis</skill>
      <instruction>The skill handles: secret scanning, injection checks, auth review, input validation.</instruction>
      <instruction>Review the skill's prioritized findings before proceeding.</instruction>
    </step>

    <step number="2" name="Check Dependencies" turbo="true">
      <command>npm audit</command>
      <command>pip-audit</command>
      <instruction>Run appropriate command based on project type.</instruction>
    </step>

    <step number="3" name="Generate Report">
      <action>Compile findings from skill and dependency audit.</action>
      <action>Prioritize by severity (Critical → High → Medium → Low).</action>
      <action>Suggest fixes for each issue.</action>
      <output>Security audit report with prioritized issues and remediation steps.</output>
    </step>
  </steps>

  <success_criteria>
    <criterion>No hardcoded secrets found</criterion>
    <criterion>All dependencies pass audit</criterion>
    <criterion>No obvious injection vulnerabilities</criterion>
    <criterion>Report generated with prioritized issues</criterion>
  </success_criteria>
</workflow>
