---
name: handoff
description: |
  End-of-session summary for handing off work to yourself tomorrow or a teammate
---

<subagent name="handoff" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>End-of-session summary for handing off work to yourself tomorrow or a teammate</purpose>

  <when_to_use>
    <trigger>End of work session</trigger>
    <trigger>Before going on vacation</trigger>
    <trigger>Passing work to a teammate</trigger>
    <trigger>Any time you need to &quot;save your mental state&quot;</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Focus ONLY on updating status and creating handoff notes in Agent-Context/Communications/Agent-Notes/</rule>
    <rule>Do not: write implementation code; modify source files</rule>
  </constraints>

  <workflow>
    <step number="1" name="Summarize What Was Done">
      <action>What features were added?</action>
      <action>What bugs were fixed?</action>
      <action>What was changed?</action>
    </step>
    <step number="2" name="Identify What&apos;s In Progress">
      <action>What&apos;s partially complete?</action>
      <action>What was the approach being taken?</action>
    </step>
    <step number="3" name="Document Dead Ends &amp; Failed Attempts">
      <action>What approaches were tried and failed?</action>
      <action>Why did they fail? (Technical limitation, complexity, etc.)</action>
      <action>What shouldn&apos;t be tried again?</action>
    </step>
    <step number="4" name="List Blockers">
      <action>Waiting on someone else?</action>
      <action>Need more information?</action>
      <action>Technical obstacle?</action>
    </step>
    <step number="5" name="Note Next Steps">
      <action>Numbered list of next actions in priority order</action>
    </step>
    <step number="6" name="Flag Any Gotchas">
      <action>Execute this step according to the workflow objective and current request context.</action>
    </step>
    <step number="7" name="Check Branch State">
      <action>Run `git status`</action>
      <action>Run `git log --oneline -5`</action>
    </step>
    <step number="8" name="Create Handoff Document">
      <action>Write summary to Agent-Context/Communications/Agent-Notes/HANDOFF.yaml (YAML format for agent consumption)</action>
      <action>Include date/time</action>
      <action>Commit if appropriate</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>All progress documented</criterion>
    <criterion>Next steps are clear</criterion>
    <criterion>Blockers are noted</criterion>
    <criterion>Someone else (or future you) can continue</criterion>
  </output_contract>

  <handoffs>
    <route>/analyze</route>
    <route>/architect</route>
    <route>/code</route>
    <route>/dependency-check</route>
    <route>/deploy</route>
    <route>/fix-issue</route>
    <route>/morning</route>
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

