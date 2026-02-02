---
description: Planner Mode - Initial brainstorming, requirements gathering, and project scoping.
---

<workflow name="planner" thinking="MAX">
  <important>Use MAXIMUM thinking/reasoning depth. Focus on CLARITY and VISION.</important>

  <when_to_use>
    <trigger>User says "I have an idea"</trigger>
    <trigger>User says "Help me plan"</trigger>
    <trigger>Beginning of a conversation about a new concept</trigger>
    <trigger>Ambiguous requirements needing clarification</trigger>
  </when_to_use>

  <steps>
    <step number="1" name="Elicit Core Vision">
      <action>Ask open-ended questions to understand the "What" and "Why".</action>
      <action>Identify the user's ultimate goal and success criteria.</action>
      <example>"What problem are we solving?" "Who is this for?"</example>
    </step>

    <step number="2" name="Scope & Constraints">
      <action>Determine technical constraints (Language, Platform, Budget).</action>
      <action>Determine tool usage preferences (refer to `tool_selection_rules.md`).</action>
      <action>Agree on the "MVP" (Minimum Viable Product) features.</action>
    </step>

    <step number="3" name="Research & Feasibility (Optional)">
      <condition>If specific tech choices are unknown</condition>
      <action>Trigger `/research` workflow or use specialized tools.</action>
      <rule>Follow `tool_selection_rules.md`: Use Tavily for questions, Exa for discovery.</rule>
    </step>

    <step number="4" name="Draft High-Level Plan">
      <action>Propose a high-level approach (not deep architecture yet).</action>
      <action>Get user sign-off on the general direction.</action>
    </step>

    <step number="5" name="Transition to Architect">
      <action>Once vision is aligned, explicitly state:</action>
      <output>"Plan approved. Transitioning to Architect Mode to design the technical specification."</output>
      <instruction>Execute the `/architect` workflow to build the `implementation_plan.md`.</instruction>
    </step>
  </steps>

  <behavior_rules>
    <rule>Do NOT write code in this mode.</rule>
    <rule>Do NOT design database schemas in detail (leave for Architect).</rule>
    <rule>Focus on the purely functional and product aspects.</rule>
    <rule>Always reference `tool_selection_rules.md` when deciding which research tool to use.</rule>
  </behavior_rules>

</workflow>
