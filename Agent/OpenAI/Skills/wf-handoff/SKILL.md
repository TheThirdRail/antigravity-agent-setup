---
name: wf-handoff
description: |
  OpenAI Codex orchestration skill converted from `handoff.md`.
  Use when End of work session; Before going on vacation; Passing work to a teammate.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-handoff" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, handoff, openai, codex</keywords>
    <source_workflow>handoff.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-handoff</id>
    <name>wf-handoff</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>End-of-session summary for handing off work to yourself tomorrow or a teammate</purpose>
    <inputs>
      <input>User request and relevant project context.</input>
    </inputs>
    <outputs>
      <output>Completed guidance, actions, or artifacts produced by this skill.</output>
    </outputs>
    <triggers>
      <trigger>Use when the frontmatter description conditions are met.</trigger>
    </triggers>
    <procedure>Follow the ordered steps in the workflow section.</procedure>
    <edge_cases>
      <edge_case>If required context is missing, gather or request it before continuing.</edge_case>
    </edge_cases>
    <safety_constraints>
      <constraint>Avoid destructive operations without explicit user intent.</constraint>
    </safety_constraints>
    <examples>
      <example>Activate this skill when the request matches its trigger conditions.</example>
    </examples>
  </spec_contract>

  <goal>End-of-session summary for handing off work to yourself tomorrow or a teammate</goal>

  <core_principles>
    <principle name="Orchestrate First">
      <rule>Act as an orchestration skill: sequence actions, call specialized skills, and keep task focus.</rule>
    </principle>
    <principle name="Deterministic Flow">
      <rule>Follow the ordered step flow from the source workflow unless constraints require adaptation.</rule>
    </principle>
    <principle name="Validation Before Completion">
      <rule>Require verification checks before marking the workflow complete.</rule>
    </principle>
    <principle name="Source Constraints">
      <rule>DO NOT write implementation code</rule>
      <rule>DO NOT modify source files</rule>
      <rule>Focus ONLY on updating status and creating handoff notes in Agent-Context/Communications/Agent-Notes/</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Summarize What Was Done">
      <instruction>What features were added? What bugs were fixed? What was changed?</instruction>
    </step>
    <step number="2" name="Identify What's In Progress">
      <instruction>What's partially complete? What was the approach being taken?</instruction>
    </step>
    <step number="3" name="Document Dead Ends &amp; Failed Attempts">
      <instruction>What approaches were tried and failed? Why did they fail? (Technical limitation, complexity, etc.) What shouldn't be tried again?</instruction>
    </step>
    <step number="4" name="List Blockers">
      <instruction>Waiting on someone else? Need more information? Technical obstacle?</instruction>
    </step>
    <step number="5" name="Note Next Steps">
      <instruction>Numbered list of next actions in priority order</instruction>
    </step>
    <step number="6" name="Flag Any Gotchas">
      <instruction>"Don't run X without doing Y first" "This file is temporarily broken" "That approach didn't work because..."</instruction>
    </step>
    <step number="7" name="Check Branch State">
      <instruction>git status git log --oneline -5</instruction>
      <command>git status</command>
      <command>git log --oneline -5</command>
    </step>
    <step number="8" name="Create Handoff Document">
      <instruction>Write summary to Agent-Context/Communications/Agent-Notes/HANDOFF.yaml (YAML format for agent consumption) Include date/time Commit if appropriate</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
  </related_skills>
</skill>
