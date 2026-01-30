---
name: testing-rules
description: |
  Enforces testing mandates for all code changes.
  Ensures TDD practices and regression prevention.
activation: always_on
---

<rule name="testing-rules" version="1.0.0">
  <metadata>
    <category>code-quality</category>
    <severity>error</severity>
  </metadata>

  <purpose>Enforce mandatory testing for all logic changes to prevent regressions.</purpose>

  <constraints>
    <must>Include unit tests for all new functions</must>
    <must>Run existing tests before and after changes</must>
    <must>Generate Success Criteria before implementation</must>
    <must_not>Merge code with failing tests</must_not>
  </constraints>

  <verification_process>
    <step>Define Success Conditions (Inputs -> Expected Outputs)</step>
    <step>Write failing test (Red)</step>
    <step>Implement code (Green)</step>
    <step>Refactor and Verify</step>
  </verification_process>

  <examples>
    <good description="Test file created">
      <code>Created `tests/test_parser.py` with 5 test cases covering edge cases.</code>
    </good>
    <bad description="No tests">
      <code>Implmented the new feature directly without adding any verification.</code>
    </bad>
  </examples>
</rule>
