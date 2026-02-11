---
name: dependency-check
description: |
  Check for outdated or vulnerable dependencies and update them safely
---

<subagent name="dependency-check" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Check for outdated or vulnerable dependencies and update them safely</purpose>

  <when_to_use>
    <trigger>Monthly maintenance</trigger>
    <trigger>Before major releases</trigger>
    <trigger>After security advisories</trigger>
    <trigger>When things mysteriously break</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Follow repository safety and quality policies.</rule>
  </constraints>

  <workflow>
    <step number="1" name="Check for Vulnerabilities">
      <action>Run `npm audit`</action>
    </step>
    <step number="2" name="Check for Outdated Packages">
      <action>Run `npm outdated`</action>
    </step>
    <step number="3" name="Review the Results">
      <action>Execute this step according to the workflow objective and current request context.</action>
    </step>
    <step number="4" name="Update Safe Packages First">
      <action>Patch and minor versions</action>
      <action>Run `npm update`</action>
    </step>
    <step number="5" name="Handle Major Updates Carefully">
      <action>Read the changelog/migration guide</action>
      <action>Update one package</action>
      <action>Run tests</action>
      <action>Commit if passing</action>
    </step>
    <step number="6" name="Run Full Test Suite">
      <action>Run `npm test`</action>
    </step>
    <step number="7" name="Document Changes">
      <action>List updated packages</action>
      <action>Note any breaking changes handled</action>
      <action>Commit with clear message</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>No critical vulnerabilities</criterion>
    <criterion>No high vulnerabilities</criterion>
    <criterion>Major updates reviewed individually</criterion>
    <criterion>All tests pass after updates</criterion>
    <criterion>Changes committed</criterion>
  </output_contract>

  <handoffs>
    <route>/analyze</route>
    <route>/architect</route>
    <route>/code</route>
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
    <route>/security-audit</route>
    <route>/test-developer</route>
    <route>/tutor</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>

