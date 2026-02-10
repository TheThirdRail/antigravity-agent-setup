---
name: communication-protocol-enforcer
description: |
  Enforce standardized clarification, error recovery, and progress update communication templates.
  Use when responding to blockers, failures, or status updates during execution.
---

<skill name="communication-protocol-enforcer" version="1.0.0">
  <metadata>
    <keywords>communication, clarification, error-recovery, progress, formatting</keywords>
  </metadata>

  <goal>Provide concise, consistent, actionable communication in high-friction execution moments.</goal>

  <core_principles>
    <principle name="Actionability">
      <rule>Every blocker or error response includes a concrete recovery path.</rule>
    </principle>
    <principle name="Clarity">
      <rule>Use explicit status, blocker, and next-step fields for critical moments.</rule>
    </principle>
    <principle name="Consistency">
      <rule>Use the same protocol structure across similar situations.</rule>
    </principle>
  </core_principles>

  <protocols>
    <protocol name="Clarification">
      <format><![CDATA[
**CLARIFICATION NEEDED**
• Status: [where you are]
• Blocker: [what prevents progress]
• Question: [single explicit question]
      ]]></format>
    </protocol>
    <protocol name="Error Recovery">
      <steps>
        <step>Acknowledge the error clearly.</step>
        <step>Explain what failed in plain language.</step>
        <step>Provide immediate fix path.</step>
        <step>Request a decision if a tradeoff is required.</step>
      </steps>
    </protocol>
    <protocol name="Progress Update">
      <format><![CDATA[
**Progress:** [what was completed]
**Next:** [next concrete step]
**Blockers:** [issue] or None
      ]]></format>
    </protocol>
  </protocols>

  <workflow>
    <step number="1" name="Detect Communication Mode">
      <instruction>Classify the event as Clarification, Error Recovery, or Progress Update.</instruction>
    </step>
    <step number="2" name="Render Template">
      <instruction>Populate the corresponding protocol template with concrete task context.</instruction>
    </step>
    <step number="3" name="Validate Completeness">
      <instruction>Ensure no required field is empty before sending.</instruction>
    </step>
  </workflow>

  <pitfalls>
    <pitfall>Assuming file contents without reading first.</pitfall>
    <pitfall>Combining unrelated concerns in one update.</pitfall>
    <pitfall>Omitting the immediate next action.</pitfall>
  </pitfalls>

  <best_practices>
    <do>Explain why a recommendation is made when the path is not obvious.</do>
    <do>Keep updates short and scannable.</do>
    <dont>Use vague status updates that hide blockers.</dont>
  </best_practices>

  <related_workflows>
    <workflow>/analyze</workflow>
    <workflow>/code</workflow>
    <workflow>/review</workflow>
  </related_workflows>
</skill>