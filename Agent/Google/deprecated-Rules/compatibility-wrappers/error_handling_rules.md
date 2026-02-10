---
name: error-handling-rules
description: |
  Compatibility wrapper for migrated policy.
  Canonical policy moved to Skills/runtime-safety-enforcer/SKILL.md.
activation: always_on
---

<rule name="error-handling-rules" version="2.0.0">
  <metadata>
    <category>standards</category>
    <severity>error</severity>
  </metadata>

  <status>Compatibility wrapper. Canonical policy is maintained in modular artifacts.</status>

  <canonical_modules>
    <module file="Skills/runtime-safety-enforcer/SKILL.md" />
    <module file="Rules/GEMINI.md" />
  </canonical_modules>
</rule>