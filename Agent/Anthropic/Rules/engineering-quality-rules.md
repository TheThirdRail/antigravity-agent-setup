---
name: engineering-quality-rules
description: |
  Unified engineering quality policy for code standards, style, testing, and documentation.
  Consolidates code_standards, code_style_rules, testing_rules, and documentation_standards.
activation: always_on
---

<rule name="engineering-quality-rules" version="1.0.0">
  <metadata>
    <category>quality</category>
    <severity>error</severity>
  </metadata>

  <goal>Enforce maintainable implementation quality with consistent style, test rigor, and documentation discipline.</goal>

  <refactoring_thresholds>
    <trigger condition="File > 300 lines" severity="suggest">Recommend refactor.</trigger>
    <trigger condition="File > 500 lines" severity="strong">Strongly recommend refactor.</trigger>
    <trigger condition="File > 800 lines" severity="block">Do not add more code before refactor.</trigger>
    <trigger condition="Function > 50 lines" severity="suggest">Suggest decomposition.</trigger>
    <trigger condition="Function > 100 lines" severity="strong">Recommend decomposition immediately.</trigger>
    <trigger condition="Pattern appears 3+ times" severity="extract">Require shared utility extraction.</trigger>
  </refactoring_thresholds>

  <style_requirements>
    <rule>Use descriptive names and avoid ambiguous abbreviations.</rule>
    <rule>Function names should represent actions (verb-first naming).</rule>
    <rule>Boolean identifiers should read like yes/no questions (`is*`, `has*`, `can*`).</rule>
    <rule>Explain WHY in comments, not obvious WHAT statements.</rule>
    <rule>Extract magic values into named constants.</rule>
    <rule>Prefer explicit types over `any`; use TypeScript and Python type hints where available.</rule>
  </style_requirements>

  <testing_requirements>
    <must>Add or update tests for meaningful behavior changes.</must>
    <must>Run existing test suites before and after changes.</must>
    <must>Define success criteria for changed behavior.</must>
    <must_not>Mark work complete while critical tests fail.</must_not>
    <process>Red -> Green -> Refactor.</process>
  </testing_requirements>

  <documentation_requirements>
    <must>Update docs when functionality, setup, interfaces, or dependencies change.</must>
    <must>Document public APIs with stable docstrings/JSDoc style guidance.</must>
    <must>Update README for major feature or setup changes.</must>
    <should>Create/update ADRs for significant architecture/security/performance decisions.</should>
  </documentation_requirements>

  <tool_usage_baseline>
    <rule>Read before write.</rule>
    <rule>Prefer non-destructive inspection before mutation.</rule>
    <rule>Group related tool calls where practical.</rule>
    <rule>Confirm intent before destructive operations.</rule>
  </tool_usage_baseline>
</rule>
