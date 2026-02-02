---
description: Project Setup - Initialize project structure after Architect Mode planning
---

<workflow name="project-setup" thinking="Normal">
  <purpose>Initialize project structure AFTER /architect planning is complete.</purpose>

  <when_to_use>
    <trigger>After /architect has created prd.md, checklist.md</trigger>
    <trigger>Before starting /code implementation</trigger>
    <trigger>To set up file structure and configuration</trigger>
  </when_to_use>

  <prerequisites>
    <prerequisite>/architect workflow MUST be completed first</prerequisite>
    <prerequisite>prd.md and checklist.md should exist</prerequisite>
    <prerequisite>Project requirements are clear</prerequisite>
  </prerequisites>

  <steps>
    <step number="1" name="Create .gitignore">
      <content><![CDATA[
# Dependencies
node_modules/
vendor/
.venv/
__pycache__/

# Build outputs

dist/
build/
.next/

# Environment

.env
.env.local
.env.*.local

# IDE

.idea/
.vscode/settings.json

# AI/Agent Generated (DO NOT COMMIT)

Agent-Context/

# Testing

coverage/

# Temporary

tmp/
temp/
      ]]></content>
    </step>

    <step number="2" name="Create Agent-Context Folder Structure">
      <instruction>Create the Agent-Context directory tree for all agent-generated files.</instruction>
      <folders>
        <folder>Agent-Context/Research</folder>
        <folder>Agent-Context/Lessons</folder>
        <folder>Agent-Context/PRD</folder>
        <folder>Agent-Context/Plan</folder>
        <folder>Agent-Context/Tasks</folder>
        <folder>Agent-Context/Communications/Agent-Notes</folder>
        <folder>Agent-Context/Communications/Proj-Mgr-Notes</folder>
        <folder>Agent-Context/Misc</folder>
      </folders>
      <note>Agent-Notes uses YAML format for structured agent-to-agent communication.</note>
      <note>Proj-Mgr-Notes uses Markdown for human-readable artifacts.</note>
    </step>

    <step number="3" name="Create Project Structure">
      <skill ref="architecture-planner">Use for structure decisions</skill>
      <instruction>Based on the tech stack from /architect, create appropriate folders</instruction>
      <template type="Web/Node">src/components/, src/pages/, src/utils/, public/, tests/, docs/</template>
      <template type="Python">src/, tests/, docs/, scripts/</template>
    </step>

    <step number="3" name="Generate Workspace Rules">
      <skill ref="rule-builder">Use to create project-specific rules</skill>
      <instruction>Create `.agent/rules/project-rules.md` using the rule-builder format</instruction>
      <content><![CDATA[
---

name: project-rules
description: |
  Workspace-specific rules for this project.
  Includes stack conventions and testing requirements.
activation: always_on
---

<rule name="project-rules" version="1.0.0">
  <metadata>
    <category>project-specific</category>
    <severity>error</severity>
  </metadata>

  <conventions>
    <stack>[Tech Stack identified in Architect]</stack>
    <style>Standard linter rules</style>
  </conventions>

  <constraints>
    <must>Run tests before commit</must>
    <must>Follow architecture patterns defined in /architect</must>
  </constraints>
</rule>
      ]]></content>
      <action>Ensure it fits within 12,000 char limit</action>
    </step>

    <step number="4" name="Initialize Git" optional="true">
      <command>git init</command>
      <command>git add .</command>
      <command>git commit -m "Initial project setup"</command>
    </step>

    <step number="5" name="Create README.md">
      <content>Project name and description (from prd.md)</content>
      <content>Installation instructions</content>
      <content>Usage examples</content>
      <content>Contributing guidelines</content>
    </step>

    <step number="6" name="Prepare for Implementation">
      <action>Inform user that project is ready</action>
      <action>Suggest proceeding with /code workflow</action>
    </step>
  </steps>

  <exit_criteria>
    <criterion>All configuration files created</criterion>
    <criterion>Folder structure matches architecture</criterion>
    <criterion>Ready to proceed with /code</criterion>
  </exit_criteria>
</workflow>
