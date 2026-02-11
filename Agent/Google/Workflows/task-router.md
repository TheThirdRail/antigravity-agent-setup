---
description: Recommend the next slash command by classifying request intent against the workflow trigger map.
---

<workflow name="task-router" thinking="Normal">
  <metadata>
    <description>Deterministic slash-command recommender with confidence scoring and fallback guidance.</description>
  </metadata>

  <important>This workflow recommends commands. It does not auto-dispatch or chain-execute other workflows.</important>

  <inputs>
    <field>request_text</field>
    <field optional="true">user_declined_routing</field>
  </inputs>

  <routing_table>
    <route trigger="Idea/Brainstorming" workflow="/architect" />
    <route trigger="Planning/Design" workflow="/architect" />
    <route trigger="Debugging/Issues" workflow="/analyze" />
    <route trigger="Surgical Debugging" workflow="/fix-issue surgical" />
    <route trigger="Implementation" workflow="/code" />
    <route trigger="Researching" workflow="/research" />
    <route trigger="Learning/Docs" workflow="/tutor" />
    <route trigger="Project Setup" workflow="/project-setup" />
    <route trigger="Refactoring" workflow="/refactor" />
    <route trigger="Pull Request" workflow="/pr" />
    <route trigger="Testing/TDD" workflow="/test-developer" />
    <route trigger="Security Audit" workflow="/security-audit" />
    <route trigger="Fix Issue" workflow="/fix-issue" />
    <route trigger="Handoff" workflow="/handoff" />
    <route trigger="Morning Routine" workflow="/morning" />
    <route trigger="New Codebase" workflow="/onboard" />
    <route trigger="Dependency Check" workflow="/dependency-check" />
    <route trigger="Deployment" workflow="/deploy" />
    <route trigger="Performance Optimization" workflow="/performance-tune" />
    <route trigger="Code Review" workflow="/review" />
  </routing_table>

  <steps>
    <step number="1" name="Classify Request">
      <instruction>Map `request_text` to the closest trigger class in the routing table.</instruction>
      <instruction>Only map to `Learning/Docs -> /tutor` when the user explicitly asks for teaching, explanation, or learning support.</instruction>
      <instruction>If `request_text` already contains an explicit slash command, return `recommended_command=no-reroute`.</instruction>
    </step>
    <step number="2" name="Resolve Workflow">
      <instruction>Select the highest-confidence slash command and produce a concise rationale.</instruction>
    </step>
    <step number="3" name="Handle Ambiguity">
      <instruction>If confidence is low, ask one targeted disambiguation question and defer recommendation.</instruction>
      <instruction>If `user_declined_routing=true`, return `recommended_command=no-reroute` and provide a direct-execution fallback note.</instruction>
    </step>
    <step number="4" name="Return Route Decision">
      <instruction>Output recommendation contract fields only; do not execute downstream workflows.</instruction>
      <instruction>Set `confidence` to `high`, `medium`, or `low`.</instruction>
    </step>
  </steps>

  <output_format>
    <field>recommended_command</field>
    <field>confidence</field>
    <field>reason</field>
    <field>alternate_command</field>
    <field>next_step_instruction</field>
  </output_format>

  <failure_modes>
    <mode>Unknown trigger: set `recommended_command=/analyze` and request one clarification.</mode>
    <mode>Multiple valid routes: return top two options and explain selection rationale.</mode>
    <mode>User already provided slash command: return `recommended_command=no-reroute`.</mode>
  </failure_modes>

  <exit_criteria>
    <criterion>A recommendation contract is returned with rationale and next-step guidance.</criterion>
  </exit_criteria>
</workflow>
