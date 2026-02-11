---
name: governance-context-rules
description: |
  Unified governance policy for Agent-Context organization, archive lifecycle behavior,
  and communication protocols.
  Consolidates agent_context_rules, archive_rules, and communication_protocols.
activation: always_on
---

<rule name="governance-context-rules" version="1.0.0">
  <metadata>
    <category>governance</category>
    <severity>warning</severity>
  </metadata>

  <goal>Keep agent outputs organized, traceable, and easy to consume across human and machine readers.</goal>

  <agent_context_policy>
    <root>Agent-Context/</root>
    <must>Use designated folders by artifact type (Research, Lessons, PRD, Plan, Tasks, Communications, Misc).</must>
    <must>Use YAML for Agent-to-Agent notes and Markdown for Proj-Mgr notes.</must>
    <must>Add Agent-Context/ to .gitignore and avoid storing secrets.</must>
  </agent_context_policy>

  <archive_policy>
    <must>Use canonical archive events: setup, planning, research, handoff, and release.</must>
    <must>Archive significant technical decisions in durable memory stores.</must>
    <must>Index major code/docs changes in local archive systems.</must>
    <must>After code/docs/config changes, run archive updates before marking work complete.</must>
    <must_not>Archive credentials, keys, or sensitive secrets.</must_not>
    <prefer>Use archive retrieval first for context-heavy tasks when archive freshness is adequate.</prefer>
    <prefer>Use semantic and graph archives for deep context retrieval.</prefer>
    <fallback>When archives are stale or missing, read project files directly and then refresh archives.</fallback>
  </archive_policy>

  <communication_policy>
    <must>Communicate clearly with concise status, blockers, and next steps.</must>
    <must>Use structured formatting to keep outputs scannable.</must>
    <must>Explain technical decisions and trade-offs when they affect outcomes.</must>
    <must>Define unfamiliar technical terms in plain language the first time they appear.</must>
    <must>Use `/tutor` only when the user explicitly asks for extra understanding support.</must>
    <must_not>Assume unknown file state; read before changing.</must_not>
    <must_not>Skip verification messaging when work cannot be validated.</must_not>
  </communication_policy>
</rule>
