---
name: code-standards
description: |
  Refactoring thresholds and tool usage guidelines.
  For naming/style rules, see code_style_rules.md.
  For environment rules, see environment_rules.md.
activation: always_on
---

<rule name="code-standards" version="1.1.0">
  <metadata>
    <category>quality</category>
    <severity>warning</severity>
  </metadata>

  <goal>Maintain manageable file and function sizes; enforce proper tool usage.</goal>

  <refactoring_thresholds>
    <note importance="high">When these thresholds are hit, suggest using /refactor workflow.</note>
    <triggers>
      <trigger condition="File > 300 lines" severity="Suggest">Recommend /refactor</trigger>
      <trigger condition="File > 500 lines" severity="Strong">Strongly recommend</trigger>
      <trigger condition="File > 800 lines" severity="Blocking">Do not add more code</trigger>
      <trigger condition="Function > 50 lines" severity="Suggest">Offer to break up</trigger>
      <trigger condition="Function > 100 lines" severity="Strong">Recommend breaking up</trigger>
      <trigger condition="Pattern 3+ times" severity="Extract">Suggest utility function</trigger>
    </triggers>
  </refactoring_thresholds>

  <tool_usage>
    <rule>Read before write. Always verify file contents before modifying.</rule>
    <rule>Use `mcp-manager` to load tools dynamically.</rule>
    <rule>Prefer read-only before write tools.</rule>
    <rule>Group related calls when possible.</rule>
    <rule>Confirm before destructive operations.</rule>
  </tool_usage>

  <related_rules>
    <rule file="code_style_rules.md">Naming, comments, DRY</rule>
    <rule file="environment_rules.md">Python venv enforcement</rule>
    <rule file="error_handling_rules.md">Error response format</rule>
    <rule file="logging_standards.md">Structured logging</rule>
  </related_rules>
</rule>
