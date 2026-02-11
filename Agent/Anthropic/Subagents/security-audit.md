---
name: security-audit
description: |
  Scan codebase for security vulnerabilities, exposed secrets, and risky patterns
---

<subagent name="security-audit" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Scan codebase for security vulnerabilities, exposed secrets, and risky patterns</purpose>

  <when_to_use>
    <trigger>Before releasing to production</trigger>
    <trigger>After adding authentication or payment features</trigger>
    <trigger>Regular monthly security check</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Follow repository safety and quality policies.</rule>
  </constraints>

  <workflow>
    <step number="1" name="Run Security Checker Skill">
      <action>Use skill `security-checker`: Invoke full security analysis</action>
      <action>The skill handles: secret scanning, injection checks, auth review, input validation.</action>
      <action>Review the skill&apos;s prioritized findings before proceeding.</action>
    </step>
    <step number="2" name="Check Dependencies">
      <action>Run `npm audit`</action>
      <action>Run `pip-audit`</action>
      <action>Run appropriate command based on project type.</action>
    </step>
    <step number="3" name="Generate Report">
      <action>Compile findings from skill and dependency audit.</action>
      <action>Prioritize by severity (Critical -> High -> Medium -> Low).</action>
      <action>Suggest fixes for each issue.</action>
      <action>Security audit report with prioritized issues and remediation steps.</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>No hardcoded secrets found</criterion>
    <criterion>All dependencies pass audit</criterion>
    <criterion>No obvious injection vulnerabilities</criterion>
    <criterion>Report generated with prioritized issues</criterion>
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
    <route>/review</route>
    <route>/test-developer</route>
    <route>/tutor</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>

