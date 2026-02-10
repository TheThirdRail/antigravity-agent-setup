---
name: agent-context-rules
description: |
  Compatibility wrapper for migrated policy.
  Canonical policy moved to Workflows/context-governance.md.
activation: always_on
---

<rule name="agent-context-rules" version="2.0.0">
  <metadata>
    <category>workflow</category>
    <severity>info</severity>
  </metadata>

  <status>Compatibility wrapper. Canonical policy is maintained in modular artifacts.</status>

  <canonical_modules>
    <module file="Workflows/context-governance.md" />
    <module file="Rules/GEMINI.md" />
  </canonical_modules>
</rule>