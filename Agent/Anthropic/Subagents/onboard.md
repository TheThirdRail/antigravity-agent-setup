---
name: onboard
description: |
  Systematic onboarding for new or inherited codebases
---

<subagent name="onboard" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Build confidence and verify understanding through actual contribution</purpose>

  <when_to_use>
    <trigger>Joining a new project</trigger>
    <trigger>Inheriting a codebase from another developer</trigger>
    <trigger>First time working with an unfamiliar repository</trigger>
    <trigger>Returning to a project after extended absence (months)</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Configuration/scaffolding (e.g. .env) is permitted</rule>
    <rule>Do not: write implementation code; modify source files (read-only for understanding)</rule>
  </constraints>

  <workflow>
    <step number="1" name="Map the Repository">
      <action>Explore directory structure and identify key files</action>
      <action>Mental model of project structure</action>
    </step>
    <step number="2" name="Understand the Domain">
      <action>Use skill `research-capability`: Use to look up unfamiliar concepts/patterns</action>
      <action>Gather business context and domain knowledge</action>
    </step>
    <step number="3" name="Set Up Local Environment">
      <action>Prepare development environment following project conventions</action>
    </step>
    <step number="4" name="Verify Everything Works">
      <action>Run tests and start the application</action>
    </step>
    <step number="5" name="Trace Key Code Paths">
      <action>Follow execution from entry point through core functionality</action>
    </step>
    <step number="6" name="Document Findings">
      <action>Create onboarding notes for future reference</action>
      <action>High-level system description Important files and their purposes Frequently used commands Non-obvious quirks or warnings Things still unclear</action>
    </step>
    <step number="7" name="Identify First Contribution">
      <action>Find a small, low-risk task to start contributing</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>Tests pass (or you understand why they fail)</criterion>
    <criterion>Application starts without errors</criterion>
    <criterion>Can perform basic operations</criterion>
    <criterion>Can explain what the project does in 2-3 sentences</criterion>
    <criterion>Development environment is working</criterion>
    <criterion>Understand how to run tests and start the app</criterion>
    <criterion>Know where to find key functionality</criterion>
    <criterion>Have documented initial findings</criterion>
  </output_contract>

  <handoffs>
    <route>/code</route>
    <route>/morning</route>
    <route>/research</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>

