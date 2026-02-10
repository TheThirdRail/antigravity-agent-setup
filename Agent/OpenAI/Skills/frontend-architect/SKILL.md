---
name: frontend-architect
description: |
  Design scalable, accessible, and responsive frontend systems with clear
  component boundaries and state strategy. Use when planning UI architecture,
  implementing component systems, or improving accessibility and performance.
---

<skill name="frontend-architect" version="2.0.0">
  <metadata>
    <keywords>frontend, ui, components, state-management, responsive, accessibility</keywords>
  </metadata>

  <spec_contract>
    <id>frontend-architect</id>
    <name>frontend-architect</name>
    <version>2.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Build maintainable frontend architecture that balances user experience, accessibility, and performance.</purpose>
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

  <goal>Build maintainable frontend architecture that balances user experience, accessibility, and performance.</goal>

  <core_principles>
    <principle name="Composable Components">
      <rule>Prefer small reusable components with explicit inputs and outputs.</rule>
      <rule>Separate rendering concerns from data-fetching/business logic.</rule>
    </principle>

    <principle name="Right-Sized State">
      <rule>Use local state first; promote to shared state only when multiple consumers require it.</rule>
      <rule>Treat server state distinctly from UI state.</rule>
    </principle>

    <principle name="Accessibility by Default">
      <rule>Keyboard navigation, semantic markup, and contrast checks are baseline requirements.</rule>
      <rule>Use references/accessibility-patterns.md as implementation checklist.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Clarify Product and UX Constraints">
      <question>What user outcomes and device/browser targets are required?</question>
      <question>What design tokens or system constraints already exist?</question>
    </step>

    <step number="2" name="Design Component and Data Boundaries">
      <instruction>Map page-level features to reusable components and ownership boundaries.</instruction>
      <output>Component hierarchy and data-flow map</output>
    </step>

    <step number="3" name="Select State and Fetching Strategy">
      <instruction>Define local/shared/server state responsibilities and cache strategy.</instruction>
      <check>Minimal global state footprint</check>
    </step>

    <step number="4" name="Implement Responsive and Accessible UI">
      <instruction>Apply responsive layout system and accessibility checklist from references.</instruction>
      <check>Loading, empty, error, and focus states are defined</check>
    </step>

    <step number="5" name="Validate and Harden">
      <instruction>Run keyboard, screen reader, and performance checks before finalization.</instruction>
      <tool>axe DevTools</tool>
      <tool>Browser Lighthouse/Performance panel</tool>
    </step>
  </workflow>

  <resources>
    <reference file="references/accessibility-patterns.md">WCAG-oriented checks and reusable accessibility patterns.</reference>
  </resources>

  <best_practices>
    <do>Favor semantic HTML and explicit labels for interactive elements</do>
    <do>Keep components focused and testable in isolation</do>
    <do>Define a consistent styling and token strategy early</do>
    <do>Plan for loading, empty, and error states up front</do>
    <dont>Over-centralize state without clear consumers</dont>
    <dont>Ship features without keyboard and focus behavior validation</dont>
    <dont>Hardcode breakpoints and tokens across components</dont>
  </best_practices>

  <related_skills>
    <skill>api-builder</skill>
    <skill>test-generator</skill>
    <skill>code-reviewer</skill>
  </related_skills>
</skill>
