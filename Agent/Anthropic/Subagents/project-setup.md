---
name: project-setup
description: |
  Project Setup - Initialize project structure after Architect Mode planning
---

<subagent name="project-setup" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Initialize project structure AFTER /architect planning is complete.</purpose>

  <when_to_use>
    <trigger>After /architect has created prd.md, checklist.md</trigger>
    <trigger>Before starting /code implementation</trigger>
    <trigger>To set up file structure and configuration</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Follow repository safety and quality policies.</rule>
  </constraints>

  <workflow>
    <step number="1" name="Create .gitignore">
      <action>Use the structured template/content block provided in the source workflow, including archive ignores (`Agent-Context/Archives/`, `Archive/`).</action>
    </step>
    <step number="2" name="Create Agent-Context Folder Structure">
      <action>Create the Agent-Context directory tree for all agent-generated files.</action>
      <action>Agent-Notes uses YAML format for structured agent-to-agent communication.</action>
      <action>Proj-Mgr-Notes uses Markdown for human-readable artifacts.</action>
    </step>
    <step number="3" name="Create Project Structure">
      <action>Use skill `architecture-planner`: Use for structure decisions</action>
      <action>Based on the tech stack from /architect, create appropriate folders</action>
      <action>src/components/, src/pages/, src/utils/, public/, tests/, docs/</action>
      <action>src/, tests/, docs/, scripts/</action>
    </step>
    <step number="4" name="Generate Workspace Rules">
      <action>Use skill `rule-builder`: Use to create project-specific rules</action>
      <action>Create `.agent/rules/project-rules.md` using the rule-builder format</action>
      <action>Use the structured template/content block provided in the source workflow.</action>
      <action>Ensure it fits within 12,000 char limit</action>
    </step>
    <step number="5" name="Initialize Git">
      <action>Run `git init`</action>
      <action>Run `git add .`</action>
      <action>Run `git commit -m &quot;Initial project setup&quot;`</action>
    </step>
    <step number="6" name="Create README.md">
      <action>Project name and description (from prd.md)</action>
      <action>Installation instructions</action>
      <action>Usage examples</action>
      <action>Contributing guidelines</action>
    </step>
    <step number="7" name="Prepare for Implementation">
      <action>Inform user that project is ready</action>
      <action>Suggest proceeding with /code workflow</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>All configuration files created</criterion>
    <criterion>Folder structure matches architecture</criterion>
    <criterion>Ready to proceed with /code</criterion>
  </output_contract>

  <handoffs>
    <route>/architect</route>
    <route>/code</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>

