---
name: subagent-builder
description: |
  Create and maintain Claude Code subagents using embedded XML in Markdown,
  with consistent handoffs, constraints, and install scripts. Use when adding
  or updating subagents in `Agent/Anthropic/Subagents`.
---

<skill name="subagent-builder" version="1.0.0">
  <metadata>
    <keywords>subagents, claude, builder, xml, orchestration</keywords>
  </metadata>

  <goal>Build Anthropic subagents as YAML-frontmatter markdown files with embedded XML bodies and deterministic install paths.</goal>

  <core_principles>
    <principle name="Structured Subagents">
      <rule>Use YAML frontmatter for discovery and XML body for machine-parseable structure.</rule>
      <rule>Keep route names and filenames in kebab-case and aligned one-to-one.</rule>
    </principle>

    <principle name="Deterministic Handoffs">
      <rule>Handoffs must point only to valid canonical subagent routes.</rule>
      <rule>Do not reference workflow XML tags or non-route tokens as handoffs.</rule>
    </principle>

    <principle name="Portable Install Paths">
      <rule>Use builder scripts for global and workspace installs instead of manual path edits.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Define Subagent Contract">
      <question>What outcome should this subagent deliver?</question>
      <question>When should it be invoked?</question>
      <question>What constraints must always apply?</question>
    </step>

    <step number="2" name="Initialize Subagent File">
      <instruction>Scaffold a new XML subagent file template.</instruction>
      <command>scripts/init_subagent.ps1 -Name "subagent-name" -Path "Agent/Anthropic/Subagents"</command>
    </step>

    <step number="3" name="Author Embedded XML">
      <format>YAML frontmatter + XML body</format>
      <template><![CDATA[
---
name: subagent-name
description: |
  Briefly describe when to invoke this subagent.
---

<subagent name="subagent-name" version="1.0.0">
  <purpose>Describe intended outcome.</purpose>
  <when_to_use>
    <trigger>Primary trigger.</trigger>
  </when_to_use>
  <constraints>
    <rule>Primary guardrail.</rule>
  </constraints>
  <workflow>
    <step number="1" name="Step Name">
      <action>Deterministic action.</action>
    </step>
  </workflow>
  <output_contract>
    <criterion>Completion criterion.</criterion>
  </output_contract>
  <handoffs>
    <route>/analyze</route>
  </handoffs>
</subagent>
      ]]></template>
    </step>

    <step number="4" name="Validate Routes and Structure">
      <instruction>Run Anthropic subagent validation before installation.</instruction>
      <command>Agent/Anthropic/Scripts/validate-subagents.ps1</command>
    </step>

    <step number="5" name="Install Subagent">
      <decision_tree>
        <branch condition="Global install">
          <action>Run: scripts/move-global-subagent.ps1 -Name "subagent-name.md" -Vendor "anthropic"</action>
        </branch>
        <branch condition="Workspace install">
          <action>Run: scripts/move-local-subagent.ps1 -Name "subagent-name.md" -Vendor "anthropic"</action>
        </branch>
      </decision_tree>
    </step>
  </workflow>

  <resource_folders>
    <folder name="scripts/" purpose="Subagent scaffolding and installation utilities">
      <file>init_subagent.ps1</file>
      <file>move-global-subagent.ps1</file>
      <file>move-local-subagent.ps1</file>
    </folder>
  </resource_folders>

  <best_practices>
    <do>Keep step actions concise and deterministic.</do>
    <do>Use explicit output criteria so completion state is testable.</do>
    <do>Prefer single-responsibility subagents and hand off for adjacent tasks.</do>
    <dont>Mix markdown heading sections with XML runtime sections in the same subagent file.</dont>
    <dont>Emit invalid handoff routes.</dont>
  </best_practices>

  <related_skills>
    <skill>skill-builder</skill>
    <skill>workflow-builder</skill>
  </related_skills>
</skill>
