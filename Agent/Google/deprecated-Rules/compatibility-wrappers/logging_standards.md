---
name: logging-standards
description: |
  Compatibility wrapper for migrated policy.
  Canonical policy moved to Skills/runtime-safety-enforcer/SKILL.md.
activation: always_on
---

<rule name="logging-standards" version="2.0.0">
  <metadata>
    <category>observability</category>
    <severity>warning</severity>
  </metadata>

  <status>Compatibility wrapper. Canonical policy is maintained in modular artifacts.</status>

  <canonical_modules>
    <module file="Skills/runtime-safety-enforcer/SKILL.md" />
    <module file="Rules/GEMINI.md" />
  </canonical_modules>
</rule>