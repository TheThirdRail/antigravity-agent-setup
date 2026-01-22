---
description: Architect Mode - Plan and design a new feature or project from scratch
---

<workflow name="architect" thinking="MAX">
  <important>Use MAXIMUM thinking/reasoning depth. Plan thoroughly before any implementation.</important>

  <when_to_use>
    <trigger>Starting a new project from scratch</trigger>
    <trigger>Planning a major new feature</trigger>
    <trigger>Designing system architecture</trigger>
  </when_to_use>

  <steps>
    <step number="1" name="Clarify Requirements">
      <action>Ask questions about scope, requirements, and constraints</action>
      <action>DO NOT proceed until critical questions are answered</action>
      <action>Understand the user's vision completely</action>
    </step>

    <step number="2" name="Research Best Practices">
      <action>Use web search to find current best practices for the relevant tech stack</action>
      <action>Research project structure conventions</action>
      <action>Research security and performance best practices</action>
      <action>Document findings for reference</action>
    </step>

    <step number="3" name="Design Architecture">
      <action>Create high-level architecture including tech stack decisions</action>
      <action>Define file/folder structure</action>
      <action>Create data flow diagrams</action>
      <action>Identify dependencies and integration points</action>
    </step>

    <step number="4" name="Generate Documentation">
      <output file="prd.md">Goals, user stories, acceptance criteria, technical requirements, scope</output>
      <output file="checklist.md">Phased implementation plan with atomic, checkable tasks</output>
      <output file="project_rules.md">Tech stack, coding conventions, linting rules, naming conventions</output>
    </step>

    <step number="5" name="Index the Project">
      <tool name="mem0">Store architectural decisions</tool>
      <tool name="codegraph">Index code relationships</tool>
      <tool name="ragdocs">Vector search for docs</tool>
    </step>

    <step number="6" name="Track Tasks">
      <action>Register checklist items with task manager if available</action>
      <action>Otherwise, use checklist.md as the source of truth</action>
    </step>
  </steps>

  <exit_criteria>
    <criterion>All documentation files created</criterion>
    <criterion>User has reviewed and approved the plan</criterion>
    <criterion>Ready to transition to /code workflow</criterion>
  </exit_criteria>
</workflow>
