---
name: agent-context-rules
description: |
  Defines the Agent-Context folder structure and usage guidelines.
  All agent-generated files must be placed in the appropriate subfolder.
activation: always_on
---

<rule name="agent-context-rules" version="1.0.0">
  <metadata>
    <category>workflow</category>
    <severity>error</severity>
  </metadata>

  <folder_structure>
    <root>Agent-Context/</root>
    <folder name="Research">Research reports from /research workflow</folder>
    <folder name="Lessons">Tutorials and learning materials from /tutor workflow</folder>
    <folder name="PRD">PRD and checklist files from /architect workflow</folder>
    <folder name="Plan">Architecture plans, tech stack decisions (YAML structured)</folder>
    <folder name="Tasks">Task tracking and progress files</folder>
    <folder name="Communications/Agent-Notes">Agent-to-agent notes (YAML format)</folder>
    <folder name="Communications/Proj-Mgr-Notes">Human-readable artifacts (Markdown)</folder>
    <folder name="Misc">Other non-project files that don't fit elsewhere</folder>
  </folder_structure>

  <format_requirements>
    <format folder="Agent-Notes" type="YAML">
      <reason>Token-efficient, excellent LLM comprehension</reason>
      <structure>
        <field>type: agent_note | finding | observation | warning</field>
        <field>id: unique-id</field>
        <field>created: ISO timestamp</field>
        <field>source_agent: originating workflow/agent</field>
        <field>target_agents: [list of intended recipients]</field>
        <field>priority: high | medium | low</field>
        <field>topic: brief subject</field>
        <field>context: situation description</field>
        <field>finding: specific insight</field>
        <field>action_required: what to do</field>
        <field>related_files: [paths]</field>
        <field>tags: [keywords]</field>
      </structure>
    </format>
    <format folder="Proj-Mgr-Notes" type="Markdown">
      <reason>Human readability</reason>
    </format>
    <format folder="Plan" type="YAML-Frontmatter-Markdown">
      <reason>Structured metadata with human-readable body</reason>
    </format>
  </format_requirements>

  <constraints>
    <must>Create Agent-Context/ during /project-setup workflow</must>
    <must>Add Agent-Context/ to .gitignore</must>
    <must>Use correct subfolder for each file type</must>
    <must>Use YAML format for Agent-Notes</must>
    <must>Use Markdown for Proj-Mgr-Notes</must>
  </constraints>

  <related_workflows>
    <workflow file="project-setup.md">Creates folder structure</workflow>
    <workflow file="research.md">Outputs to Research/</workflow>
    <workflow file="tutor.md">Outputs to Lessons/</workflow>
    <workflow file="architect.md">Outputs to PRD/ and Plan/</workflow>
    <workflow file="handoff.md">Outputs to Communications/Agent-Notes/</workflow>
  </related_workflows>
</rule>
