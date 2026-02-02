---
name: code-standards
description: |
  Code quality standards, refactoring thresholds, and naming conventions.
  Enforces consistent, maintainable code across the codebase.
activation: always_on
---

<rule name="code-standards" version="1.0.0">
  <metadata>
    <category>quality</category>
    <severity>warning</severity>
  </metadata>

  <goal>Maintain consistent, high-quality, maintainable code.</goal>

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

  <standards>
    <standard name="Type Safety">
      TypeScript over JavaScript; type hints in Python
    </standard>
    <standard name="Naming">
      Descriptive names; avoid abbreviations; functions start with verbs
      <examples>
        <good>getUserById, isValidEmail, calculateTotalPrice</good>
        <bad>getUsr, valid, calc</bad>
      </examples>
    </standard>
    <standard name="Comments">
      Explain why, not what; document non-obvious decisions
    </standard>
    <standard name="Error Messages">
      User-friendly; include context; suggest next steps
    </standard>
    <standard name="Magic Values">
      Extract to named constants
      <examples>
        <bad>if (status === 3) { ... }</bad>
        <good>const STATUS_APPROVED = 3; if (status === STATUS_APPROVED) { ... }</good>
      </examples>
    </standard>
    <standard name="DRY">
      Don't Repeat Yourself — extract shared logic into utilities
    </standard>
  </standards>

  <tool_usage>
    <rule>Read before write. Always verify file contents before modifying.</rule>
    <rule>Use `mcp-manager` to load tools dynamically.</rule>
    <rule>Prefer read-only before write tools.</rule>
    <rule>Group related calls when possible.</rule>
    <rule>Confirm before destructive operations.</rule>
  </tool_usage>
  <environment_enforcement>
    <trigger>Writing or executing Python code, or installing packages.</trigger>
    <constraint>
      <STOP>DO NOT install packages globally.</STOP>
      <STOP>DO NOT run python scripts without a virtual environment.</STOP>
    </constraint>
    <protocol>
      <step>Check for existing venv (e.g. `.venv` or `venv` folders).</step>
      <step>If none exists, create one: `python -m venv .venv`.</step>
      <step>Activate it BEFORE every new terminal session or command sequence.</step>
      <step>Install dependencies ONLY into the active venv.</step>
    </protocol>
  </environment_enforcement>
</rule>
