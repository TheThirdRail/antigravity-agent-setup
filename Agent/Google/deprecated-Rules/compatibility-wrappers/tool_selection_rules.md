---
name: tool-selection-rules
description: |
  Compatibility wrapper for migrated policy.
  Canonical policy moved to Skills/tool-selection-router/SKILL.md.
activation: always_on
---

<rule name="tool-selection-rules" version="2.0.0">
  <metadata>
    <category>standards</category>
    <severity>info</severity>
  </metadata>

  <status>Compatibility wrapper. Canonical policy is maintained in modular artifacts.</status>

  <canonical_modules>
    <module file="Skills/tool-selection-router/SKILL.md" />
    <module file="Rules/GEMINI.md" />
  </canonical_modules>
</rule>