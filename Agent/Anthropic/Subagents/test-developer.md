---
name: test-developer
description: |
  Test-Driven Development workflow - write tests first, then implement code to pass them
---

<subagent name="test-developer" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Test-Driven Development workflow - write tests first, then implement code to pass them</purpose>

  <when_to_use>
    <trigger>Building new features that need to be reliable</trigger>
    <trigger>Fixing bugs (reproduce with test first)</trigger>
    <trigger>When you want confidence the code works</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Follow repository safety and quality policies.</rule>
  </constraints>

  <workflow>
    <step number="1" name="Understand the Requirement">
      <action>Define expected inputs and outputs</action>
      <action>Identify edge cases</action>
    </step>
    <step number="2" name="Write a Failing Test">
      <action>Use skill `test-generator`: Use for test structure and patterns</action>
      <action>Test the simplest case first</action>
      <action>Use descriptive test names</action>
    </step>
    <step number="3" name="Confirm Test Fails">
      <action>Run `npm test -- --watch`</action>
    </step>
    <step number="4" name="Write Minimum Code">
      <action>Implement just enough to pass the test</action>
      <action>Don&apos;t over-engineer</action>
      <action>Focus only on making the test pass</action>
    </step>
    <step number="5" name="Confirm Test Passes">
      <action>Run `npm test`</action>
    </step>
    <step number="6" name="Refactor">
      <action>Improve readability</action>
      <action>Remove duplication</action>
      <action>Keep tests passing!</action>
    </step>
    <step number="7" name="Repeat">
      <action>Go back to step 2 for the next test case</action>
      <action>Add edge cases</action>
      <action>Add error handling</action>
      <action>Build up coverage</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>All tests pass</criterion>
    <criterion>Tests cover happy path</criterion>
    <criterion>Tests cover edge cases</criterion>
    <criterion>Tests cover error scenarios</criterion>
    <criterion>Code is clean and readable</criterion>
  </output_contract>

  <handoffs>
    <route>/analyze</route>
    <route>/architect</route>
    <route>/code</route>
    <route>/dependency-check</route>
    <route>/deploy</route>
    <route>/fix-issue</route>
    <route>/handoff</route>
    <route>/morning</route>
    <route>/onboard</route>
    <route>/performance-tune</route>
    <route>/pr</route>
    <route>/project-setup</route>
    <route>/refactor</route>
    <route>/research</route>
    <route>/review</route>
    <route>/security-audit</route>
    <route>/tutor</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>

