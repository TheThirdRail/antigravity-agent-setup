---
name: workflow-builder
description: |
  Meta-skill for creating new AI agent workflows following best practices. Guides
  the process of defining workflow structure, writing YAML frontmatter, creating
  numbered steps with turbo annotations, and organizing reusable workflows.
  Produces workflows compatible with Antigravity, Claude Code, and Cursor.
---

<skill name="workflow-builder" version="1.0.0">
  <metadata>
    <keywords>workflows, meta, template, builder, automation</keywords>
  </metadata>

  <goal>Guide creation of AI agent workflows with clear numbered steps, turbo annotations, and placeholders.</goal>

  <core_principles>
    <principle name="Clarity First">
      <rule>Each step should be a single, clear action</rule>
      <rule>Use numbered steps for sequencing</rule>
      <rule>Keep workflows under 10 steps</rule>
    </principle>

    <principle name="Safe Automation">
      <rule>Use // turbo only for safe, reversible commands</rule>
      <rule>Never auto-execute destructive operations</rule>
      <rule>Always allow manual override</rule>
    </principle>

    <principle name="Reusability">
      <rule>Use placeholders like [ComponentName] or $ARGUMENTS</rule>
      <rule>Document prerequisites clearly</rule>
      <rule>Include success criteria</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Define the Workflow">
      <question>What task does this workflow accomplish?</question>
      <question>What triggers its use?</question>
      <question>What inputs does it need?</question>
      <question>What is the expected outcome?</question>
      <question>What could go wrong?</question>
    </step>

    <step number="2" name="Choose Location">
      <platform name="Antigravity">
        <workspace>.agent/workflows/</workspace>
        <global>~/.gemini/antigravity/global_workflows/</global>
      </platform>
      <naming>kebab-case, match slash command: arch.md → /arch</naming>
    </step>

    <step number="3" name="Write Workflow File">
      <format>Embedded XML in Markdown (YAML frontmatter + XML body)</format>
      <template><![CDATA[
---
description: Brief description of what this workflow does
---

<workflow name="workflow-name" thinking="MAX">
  <metadata>
    <description>Full description of the workflow</description>
  </metadata>

  <important>Key instruction the agent must follow</important>

  <when_to_use>
    <trigger>Specific situation that triggers this workflow</trigger>
  </when_to_use>

  <steps>
    <step number="1" name="Step Name">
      <instruction>What to do in this step</instruction>
    </step>

    <!-- turbo annotation for auto-run -->
    <step number="2" name="Safe Command" turbo="true">
      <command>npm test</command>
    </step>

    <step number="3" name="Decision Point">
      <condition type="if">If [condition A], proceed</condition>
      <condition type="else">Otherwise, return</condition>
    </step>
  </steps>

  <exit_criteria>
    <criterion>What must be true for workflow to complete</criterion>
  </exit_criteria>
</workflow>
      ]]></template>
      <note>The YAML frontmatter is for discovery; the XML body contains structured steps</note>
    </step>

    <step number="4" name="Use Turbo Annotations">
      <annotation name="// turbo" purpose="Auto-run ONE step" placement="Line before step"/>
      <annotation name="// turbo-all" purpose="Auto-run ALL steps" placement="Anywhere in file"/>
    </step>

    <step number="6" name="Add Placeholders">
      <placeholder syntax="[Name]" use="Visual prompt for user" example="Create [ComponentName]"/>
      <placeholder syntax="$ARGUMENTS" use="All text after command" example="/fix-issue $ARGUMENTS"/>
      <placeholder syntax="$1, $2" use="Positional arguments" example="git checkout $1"/>
    </step>

    <step number="7" name="Validate">
      <checklist>
        <item>Description explains what AND when to use</item>
        <item>Steps are numbered and clear</item>
        <item>Turbo annotations only on safe commands</item>
        <item>Placeholders documented</item>
        <item>Success criteria defined</item>
        <item>Error handling/rollback included</item>
      </checklist>
    </step>
  </workflow>

  <patterns>
    <pattern name="RIPER">
      <step>RESEARCH: Gather information</step>
      <step>INNOVATE: Brainstorm solutions</step>
      <step>PLAN: Document approach</step>
      <step>EXECUTE: Implement exactly as planned</step>
      <step>REVIEW: Validate and reflect</step>
    </pattern>

    <pattern name="TDD">
      <step>Write failing test</step>
      <step turbo="true">Run test (confirm failure)</step>
      <step>Implement minimum code</step>
      <step turbo="true">Run test (confirm success)</step>
      <step>Refactor if needed</step>
    </pattern>
  </patterns>

  <best_practices>
    <do>Keep steps numbered and sequential</do>
    <do>Use // turbo only for safe commands</do>
    <do>Include success criteria</do>
    <do>Document prerequisites</do>
    <do>Add rollback instructions for risky workflows</do>
    <do>Version control workflow files</do>
    <dont>Auto-run destructive commands</dont>
    <dont>Create mega-workflows (split into smaller ones)</dont>
    <dont>Hardcode paths or credentials</dont>
    <dont>Skip error handling</dont>
    <dont>Use vague steps</dont>
  </best_practices>

  <troubleshooting>
    <issue problem="Workflow not discovered">Check file location and extension (.md)</issue>
    <issue problem="Turbo annotation ignored">Ensure it's on line BEFORE the step</issue>
    <issue problem="Arguments not working">Use $ARGUMENTS or $1 format</issue>
    <issue problem="Steps skipped">Add explicit numbering</issue>
  </troubleshooting>

  <related_skills>
    <skill>skill-builder</skill>
    <skill>mcp-manager</skill>
    <skill>docker-ops</skill>
  </related_skills>
</skill>
