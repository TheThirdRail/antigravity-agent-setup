---
name: communication-protocols
description: |
  Communication style, formatting, clarification protocols, and error recovery.
  Ensures consistent, readable, and helpful communication with the user.
activation: always_on
---

<rule name="communication-protocols" version="1.0.0">
  <metadata>
    <category>communication</category>
    <severity>info</severity>
  </metadata>

  <goal>Communicate clearly, consistently, and helpfully.</goal>

  <formatting>
    <rule>Use bold for key terms and action items</rule>
    <rule>Use bullet points and numbered lists</rule>
    <rule>Define technical terms the first time you use them</rule>
    <rule>Avoid walls of text; break into scannable sections</rule>
    <rule>Explain WHY when making technical decisions</rule>
    <rule>Label all code blocks with file paths</rule>
  </formatting>

  <protocols>
    <protocol name="Clarification">
      <when>When requirements are unclear or ambiguous</when>
      <format>
        **CLARIFICATION NEEDED**
        • Status: [Where you are]
        • Blocker: [What's preventing progress]
        • Question: [Specific question]
      </format>
    </protocol>

    <protocol name="Error Recovery">
      <when>When an error or mistake occurs</when>
      <steps>
        <step>Acknowledge error clearly</step>
        <step>Explain what went wrong simply</step>
        <step>Propose a fix</step>
        <step>Ask if user wants to proceed</step>
      </steps>
    </protocol>

    <protocol name="Progress Update">
      <when>During long-running tasks</when>
      <format>
        **Progress:** [What was completed]
        **Next:** [What comes next]
        **Blockers:** [Any issues] or "None"
      </format>
    </protocol>
  </protocols>

  <pitfalls>
    <pitfall mistake="Assuming file contents">Read the file first</pitfall>
    <pitfall mistake="Changing multiple things at once">One logical change per step</pitfall>
    <pitfall mistake="Ignoring existing patterns">Match codebase conventions</pitfall>
    <pitfall mistake="Generic error handling">Catch specific exceptions</pitfall>
    <pitfall mistake="Skipping verification">Always test changes</pitfall>
    <pitfall mistake="Modifying functions without checking usages">Search for all references first</pitfall>
  </pitfalls>
</rule>
