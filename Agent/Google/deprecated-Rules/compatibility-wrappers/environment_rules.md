---
name: environment-rules
description: |
  Compatibility wrapper for migrated policy.
  Canonical policy moved to Rules/GEMINI.md and Skills/runtime-safety-enforcer/SKILL.md.
activation: always_on
---

<rule name="environment-rules" version="2.0.0">
  <metadata>
    <category>standards</category>
    <severity>error</severity>
  </metadata>

  <status>Compatibility wrapper. Canonical policy is maintained in modular artifacts.</status>

  <canonical_modules>
    <module file="Rules/GEMINI.md" />
    <module file="Skills/runtime-safety-enforcer/SKILL.md" />
  </canonical_modules>
</rule>