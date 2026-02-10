---
name: code-style-rules
description: |
  Compatibility wrapper for migrated policy.
  Canonical policy moved to Skills/code-style-enforcer/SKILL.md.
activation: always_on
---

<rule name="code-style-rules" version="2.0.0">
  <metadata>
    <category>quality</category>
    <severity>warning</severity>
  </metadata>

  <status>Compatibility wrapper. Canonical policy is maintained in modular artifacts.</status>

  <canonical_modules>
    <module file="Skills/code-style-enforcer/SKILL.md" />
    <module file="Rules/GEMINI.md" />
  </canonical_modules>
</rule>