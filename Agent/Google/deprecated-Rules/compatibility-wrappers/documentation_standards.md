---
name: documentation-standards
description: |
  Compatibility wrapper for migrated policy.
  Canonical policy moved to Workflows/quality-gates.md and Skills/documentation-generator/SKILL.md.
activation: always_on
---

<rule name="documentation-standards" version="2.0.0">
  <metadata>
    <category>quality</category>
    <severity>warning</severity>
  </metadata>

  <status>Compatibility wrapper. Canonical policy is maintained in modular artifacts.</status>

  <canonical_modules>
    <module file="Workflows/quality-gates.md" />
    <module file="Skills/documentation-generator/SKILL.md" />
    <module file="Rules/GEMINI.md" />
  </canonical_modules>
</rule>