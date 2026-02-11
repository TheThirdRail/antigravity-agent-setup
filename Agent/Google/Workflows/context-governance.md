---
description: Govern Agent-Context structure and archive lifecycle actions across project events.
---

<workflow name="context-governance" thinking="Normal">
  <metadata>
    <description>Validate Agent-Context folders/formats and apply archive policy actions by event type.</description>
  </metadata>

  <important>Never store credentials or secrets in Agent-Context or archive artifacts.</important>

  <inputs>
    <field>event_type</field>
    <field>project_root</field>
    <field>artifact_paths</field>
  </inputs>

  <event_policy>
    <event name="setup">Validate required folder schema and initialize missing folders when allowed.</event>
    <event name="planning">Validate PRD/Plan artifact placement and format requirements.</event>
    <event name="research">Validate Research output location and archive policy actions.</event>
    <event name="handoff">Validate Agent-Notes YAML format and communication artifact placement.</event>
    <event name="release">Validate release-traceability archive actions and sensitive-data constraints.</event>
  </event_policy>

  <required_folder_structure>
    <folder>Agent-Context/Research</folder>
    <folder>Agent-Context/Lessons</folder>
    <folder>Agent-Context/PRD</folder>
    <folder>Agent-Context/Plan</folder>
    <folder>Agent-Context/Tasks</folder>
    <folder>Agent-Context/Communications/Agent-Notes</folder>
    <folder>Agent-Context/Communications/Proj-Mgr-Notes</folder>
    <folder>Agent-Context/Misc</folder>
  </required_folder_structure>

  <format_requirements>
    <format folder="Communications/Agent-Notes">YAML</format>
    <format folder="Communications/Proj-Mgr-Notes">Markdown</format>
    <format folder="Plan">YAML frontmatter + Markdown body</format>
  </format_requirements>

  <archive_policy>
    <must>Archive significant architectural decisions to archive-memory.</must>
    <must>Index code after major refactors or new features.</must>
    <must>Index new documentation after creation.</must>
    <must>After code/docs/config changes, execute archive updates before marking work complete.</must>
    <must>Use archive-manager to route archive actions to the correct archive skill(s).</must>
    <prefer>Use fresh archive retrieval first for context-heavy tasks, then fall back to direct file reads when archives are stale.</prefer>
    <must_not>Archive credentials or secrets.</must_not>
    <must_not>Re-index unchanged codebases unnecessarily.</must_not>
  </archive_policy>

  <steps>
    <step number="1" name="Validate Folder Schema">
      <instruction>Verify required Agent-Context folders and report missing paths.</instruction>
      <instruction>If setup mode is enabled, create missing folders.</instruction>
    </step>
    <step number="2" name="Validate File Formats">
      <instruction>Enforce required formats for Agent-Notes and Proj-Mgr-Notes folders.</instruction>
    </step>
    <step number="3" name="Apply Archive Policy">
      <instruction>Apply archive actions by event type and change significance.</instruction>
      <instruction>Enforce post-change archive updates before completion for implementation/refactor/fix events.</instruction>
      <instruction>Skip unchanged targets to avoid duplicate indexing.</instruction>
    </step>
    <step number="4" name="Emit Governance Report">
      <instruction>Return actions, skipped targets, violations, and remediation steps.</instruction>
    </step>
  </steps>

  <related_skills>
    <skill>archive-manager</skill>
    <skill>archive-memory</skill>
    <skill>archive-docs</skill>
    <skill>archive-code</skill>
    <skill>archive-graph</skill>
  </related_skills>

  <output_format>
    <field>folder_schema_status</field>
    <field>format_status</field>
    <field>archive_actions</field>
    <field>violations</field>
    <field>remediation_steps</field>
  </output_format>

  <failure_modes>
    <mode>Required folders missing and creation disabled: return blocking actions.</mode>
    <mode>Sensitive data detected: block archive and require redaction.</mode>
  </failure_modes>

  <exit_criteria>
    <criterion>Context schema and archive actions are validated for the event.</criterion>
  </exit_criteria>
</workflow>
