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
    <step number="1" name="Check for Exposed Secrets">
      <skill ref="security-checker">Use for comprehensive security analysis</skill>
      <action>Look for patterns like api_key =, password =, secret =</action>
      <action>Check .env files are in .gitignore</action>
    </step>

    <step number="2" name="Review Authentication">
      <check>Check login/logout flows</check>
      <check>Verify password hashing</check>
      <check>Look for missing auth checks on protected routes</check>
    </step>

    <step number="3" name="Check Dependencies" turbo="true">
      <command>npm audit</command>
    </step>

    <step number="4" name="Review Input Handling">
      <vulnerability name="SQL injection">Unsanitized database queries</vulnerability>
      <vulnerability name="XSS">User input rendered as HTML</vulnerability>
      <vulnerability name="Command injection">User input in shell commands</vulnerability>
    </step>

    <step number="5" name="Check File Handling">
      <instruction>User input should not directly control file paths</instruction>
    </step>

    <step number="6" name="Generate Report">
      <action>List all issues found</action>
      <action>Prioritize by severity (Critical → High → Medium → Low)</action>
      <action>Suggest fixes for each issue</action>
    </step>
  </steps>

  <success_criteria>
    <criterion>No hardcoded secrets found</criterion>
    <criterion>All dependencies pass audit</criterion>
    <criterion>No obvious injection vulnerabilities</criterion>
    <criterion>Report generated with prioritized issues</criterion>
  </success_criteria>
</workflow>
