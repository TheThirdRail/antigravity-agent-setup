---
name: communication-protocols
description: |
  Compatibility wrapper for migrated policy.
  Canonical policy moved to Skills/communication-protocol-enforcer/SKILL.md.
activation: always_on
---

<rule name="communication-protocols" version="2.0.0">
  <metadata>
    <category>communication</category>
    <severity>info</severity>
  </metadata>

  <status>Compatibility wrapper. Canonical policy is maintained in modular artifacts.</status>

  <canonical_modules>
    <module file="Skills/communication-protocol-enforcer/SKILL.md" />
    <module file="Rules/GEMINI.md" />
  </canonical_modules>
</rule>