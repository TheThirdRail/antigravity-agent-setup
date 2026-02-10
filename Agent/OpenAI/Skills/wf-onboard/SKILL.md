---
name: wf-onboard
description: |
  OpenAI Codex orchestration skill converted from `onboard.md`.
  Use when Joining a new project; Inheriting a codebase from another developer; First time working with an unfamiliar repository.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-onboard" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, onboard, openai, codex</keywords>
    <source_workflow>onboard.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-onboard</id>
    <name>wf-onboard</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Systematic onboarding for new or inherited codebases</purpose>
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

  <goal>Systematic onboarding for new or inherited codebases</goal>

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
      <rule>DO NOT modify source files (read-only for understanding)</rule>
      <rule>Configuration/scaffolding (e.g. .env) is permitted</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Map the Repository">
      <instruction>Explore directory structure and identify key files Read README.md thoroughly Identify tech stack from package.json, requirements.txt, go.mod, etc. Map high-level architecture (src/, lib/, tests/, docs/) Find configuration files (.env.exa...</instruction>
    </step>
    <step number="2" name="Understand the Domain">
      <instruction>Use to look up unfamiliar concepts/patterns Gather business context and domain knowledge Read any documentation in docs/ folder Identify core entities and their relationships Understand user workflows and use cases Map external integrati...</instruction>
    </step>
    <step number="3" name="Set Up Local Environment">
      <instruction>Prepare development environment following project conventions Check prerequisites (Node version, Python version, etc.) Install dependencies (npm install, pip install, etc.) Copy .env.example to .env and configure Set up databases if need...</instruction>
    </step>
    <step number="4" name="Verify Everything Works">
      <instruction>Run tests and start the application Run test suite: npm test, pytest, go test, etc. Start development server Verify database connections Test 2-3 key user flows manually Tests pass (or you understand why they fail) Application starts wit...</instruction>
    </step>
    <step number="5" name="Trace Key Code Paths">
      <instruction>Follow execution from entry point through core functionality Trace a request from entry point to response Understand the data flow (input → processing → output) Identify key abstractions and patterns used Note any complexity or areas nee...</instruction>
    </step>
    <step number="6" name="Document Findings">
      <instruction>Create onboarding notes for future reference High-level system description Important files and their purposes Frequently used commands Non-obvious quirks or warnings Things still unclear</instruction>
    </step>
    <step number="7" name="Identify First Contribution">
      <instruction>Find a small, low-risk task to start contributing Fix a typo or documentation gap Add a missing test Address a small linting issue Complete a "good first issue" if labeled Build confidence and verify understanding through actual contribu...</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `research-capability` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>research-capability</skill>
  </related_skills>
</skill>
