---
name: code-style-rules
description: |
  Naming conventions, commenting standards, and code style guidelines.
  Ensures consistent, readable, maintainable code.
activation: always_on
---

<rule name="code-style-rules" version="1.0.0">
  <metadata>
    <category>quality</category>
    <severity>warning</severity>
  </metadata>

  <goal>Maintain consistent, readable code style across the codebase.</goal>

  <naming_conventions>
    <standard name="Descriptive Names">
      Use clear, descriptive names. Avoid abbreviations.
      <examples>
        <good>getUserById, isValidEmail, calculateTotalPrice</good>
        <bad>getUsr, valid, calc</bad>
      </examples>
    </standard>
    <standard name="Functions Start with Verbs">
      Function names should describe actions.
      <examples>
        <good>fetchUser, validateInput, sendEmail</good>
        <bad>user, input, email</bad>
      </examples>
    </standard>
    <standard name="Booleans are Questions">
      Boolean variables should read as yes/no questions.
      <examples>
        <good>isActive, hasPermission, canEdit</good>
        <bad>active, permission, edit</bad>
      </examples>
    </standard>
  </naming_conventions>

  <commenting_standards>
    <rule>Explain WHY, not WHAT. Code shows what; comments explain rationale.</rule>
    <rule>Document non-obvious decisions and trade-offs.</rule>
    <rule>Keep comments up-to-date when code changes.</rule>
    <rule>Use TODO/FIXME with ticket numbers for tracking.</rule>
    <examples>
      <good>// Using setTimeout to debounce API calls (prevent rate limiting)</good>
      <bad>// Set timeout to 500ms</bad>
    </examples>
  </commenting_standards>

  <magic_values>
    <rule>Extract magic numbers and strings to named constants.</rule>
    <examples>
      <bad>if (status === 3) { ... }</bad>
      <good>const STATUS_APPROVED = 3; if (status === STATUS_APPROVED) { ... }</good>
    </examples>
  </magic_values>

  <dry_principle>
    <rule>Don't Repeat Yourself — extract shared logic into utilities.</rule>
    <threshold>If a pattern appears 3+ times, suggest extracting to a utility function.</threshold>
  </dry_principle>

  <type_safety>
    <rule>TypeScript over JavaScript when possible.</rule>
    <rule>Type hints in Python (use mypy for validation).</rule>
    <rule>Avoid `any` type; use specific types or generics.</rule>
  </type_safety>
</rule>
