---
name: morning
description: |
  Daily startup routine - sync code, check status, prepare for work
---

<subagent name="morning" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Daily startup routine - sync code, check status, prepare for work</purpose>

  <when_to_use>
    <trigger>Start of each work day</trigger>
    <trigger>After being away from the project</trigger>
    <trigger>When returning to a project after a break</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Follow repository safety and quality policies.</rule>
  </constraints>

  <workflow>
    <step number="1" name="Sync with Remote">
      <action>Run `git fetch --all`</action>
      <action>Run `git pull`</action>
    </step>
    <step number="2" name="Check Branch Status">
      <action>Run `git status`</action>
      <action>Run `git branch -v`</action>
    </step>
    <step number="3" name="Install Dependencies">
      <action>Run `npm install`</action>
    </step>
    <step number="4" name="Run Tests">
      <action>Run `npm test`</action>
    </step>
    <step number="5" name="Check for Stashed Work">
      <action>Run `git stash list`</action>
    </step>
    <step number="6" name="Review TODO/Handoff">
      <action>Read HANDOFF.md if it exists</action>
      <action>Check issue tracker</action>
      <action>Review any notes from yesterday</action>
    </step>
    <step number="7" name="Plan the Day">
      <action>Pick 1-3 priorities</action>
      <action>Estimate time needed</action>
      <action>Identify any blockers</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>Code is up to date</criterion>
    <criterion>Tests are passing</criterion>
    <criterion>Today&apos;s priorities are clear</criterion>
  </output_contract>

  <handoffs>
    <route>/analyze</route>
    <route>/architect</route>
    <route>/code</route>
    <route>/dependency-check</route>
    <route>/deploy</route>
    <route>/fix-issue</route>
    <route>/handoff</route>
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

