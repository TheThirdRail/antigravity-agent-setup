---
name: wf-test-developer
description: |
  OpenAI Codex orchestration skill converted from `test-developer.md`.
  Use when Building new features that need to be reliable; Fixing bugs (reproduce with test first); When you want confidence the code works.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-test-developer" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, test-developer, openai, codex, testing</keywords>
    <source_workflow>test-developer.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-test-developer</id>
    <name>wf-test-developer</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Test-Driven Development workflow - write tests first, then implement code to pass them</purpose>
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

  <goal>Test-Driven Development workflow - write tests first, then implement code to pass them</goal>

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
  </core_principles>

  <workflow>
    <step number="1" name="Understand the Requirement">
      <instruction>Define expected inputs and outputs Identify edge cases</instruction>
    </step>
    <step number="2" name="Write a Failing Test">
      <instruction>Use for test structure and patterns Test the simplest case first Use descriptive test names</instruction>
    </step>
    <step number="3" name="Confirm Test Fails">
      <instruction>npm test -- --watch</instruction>
      <command>npm test -- --watch</command>
    </step>
    <step number="4" name="Write Minimum Code">
      <instruction>Implement just enough to pass the test Don't over-engineer Focus only on making the test pass</instruction>
    </step>
    <step number="5" name="Confirm Test Passes">
      <instruction>npm test</instruction>
      <command>npm test</command>
    </step>
    <step number="6" name="Refactor">
      <instruction>Improve readability Remove duplication Keep tests passing!</instruction>
    </step>
    <step number="7" name="Repeat">
      <instruction>Go back to step 2 for the next test case Add edge cases Add error handling Build up coverage</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `test-generator` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>test-generator</skill>
  </related_skills>
</skill>
