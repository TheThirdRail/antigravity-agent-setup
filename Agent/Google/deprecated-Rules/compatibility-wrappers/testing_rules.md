---
name: testing-rules
description: |
  Compatibility wrapper for migrated policy.
  Canonical policy moved to Workflows/quality-gates.md and Workflows/test-developer.md.
activation: always_on
---

<rule name="testing-rules" version="2.0.0">
  <metadata>
    <category>code-quality</category>
    <severity>error</severity>
  </metadata>

  <status>Compatibility wrapper. Canonical policy is maintained in modular artifacts.</status>

  <canonical_modules>
    <module file="Workflows/quality-gates.md" />
    <module file="Workflows/test-developer.md" />
    <module file="Rules/GEMINI.md" />
  </canonical_modules>
</rule>