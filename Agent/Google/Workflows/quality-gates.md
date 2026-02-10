---
description: Apply refactor, testing, and documentation quality gates before completion or merge.
---

<workflow name="quality-gates" thinking="Normal">
  <metadata>
    <description>Enforce refactor thresholds, testing policy, and documentation requirements as one gate process.</description>
  </metadata>

  <important>Do not mark work complete while any critical quality gate fails. This rubric is mandatory for /code, /review, /pr, and /deploy.</important>

  <inputs>
    <field>changed_files</field>
    <field>test_results</field>
    <field>docs_change_set</field>
  </inputs>

  <refactor_thresholds>
    <trigger condition="File > 300 lines">Suggest refactor.</trigger>
    <trigger condition="File > 500 lines">Strongly recommend refactor.</trigger>
    <trigger condition="File > 800 lines">Block additional implementation until refactor.</trigger>
    <trigger condition="Function > 50 lines">Suggest decomposition.</trigger>
    <trigger condition="Function > 100 lines">Strongly recommend decomposition.</trigger>
    <trigger condition="Pattern appears 3+ times">Require extraction to shared utility.</trigger>
  </refactor_thresholds>

  <testing_requirements>
    <must>Include tests for all new logic paths.</must>
    <must>Run tests before and after changes.</must>
    <must_not>Complete or merge while critical tests fail.</must_not>
    <tdd_cycle>Red -> Green -> Refactor</tdd_cycle>
  </testing_requirements>

  <documentation_requirements>
    <must>Update feature/API docs when behavior changes.</must>
    <must>Update README when setup, dependencies, or major usage changes.</must>
    <should>Create or update ADRs for significant architectural decisions.</should>
  </documentation_requirements>

  <steps>
    <step number="1" name="Refactor Threshold Check">
      <instruction>Evaluate size and duplication thresholds and route to /refactor when exceeded.</instruction>
    </step>
    <step number="2" name="Testing Gate">
      <instruction>Validate tests exist and pass for changed behavior.</instruction>
      <instruction>Validate Red -> Green -> Refactor flow for new behavior.</instruction>
    </step>
    <step number="3" name="Documentation Gate">
      <instruction>Validate docs, README, and ADR updates for relevant change types.</instruction>
    </step>
    <step number="4" name="Gate Decision">
      <instruction>Return PASS/BLOCK plus remediation checklist.</instruction>
    </step>
  </steps>

  <output_format>
    <field>refactor_gate</field>
    <field>testing_gate</field>
    <field>documentation_gate</field>
    <field>overall_status</field>
    <field>remediation_steps</field>
    <note>`overall_status` must be `PASS` or `BLOCK`.</note>
  </output_format>

  <related_skills>
    <skill>code-reviewer</skill>
    <skill>test-generator</skill>
    <skill>documentation-generator</skill>
    <skill>code-style-enforcer</skill>
  </related_skills>

  <failure_modes>
    <mode>Missing tests for logic changes: BLOCK.</mode>
    <mode>Public API changed without docs updates: BLOCK.</mode>
    <mode>Threshold exceeded without refactor plan: BLOCK.</mode>
  </failure_modes>

  <exit_criteria>
    <criterion>All gates pass or explicit remediation is provided.</criterion>
  </exit_criteria>
</workflow>
