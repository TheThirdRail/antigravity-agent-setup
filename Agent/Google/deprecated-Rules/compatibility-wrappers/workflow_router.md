---
name: workflow-router
description: |
  Compatibility wrapper for migrated policy.
  Canonical policy moved to Workflows/task-router.md.
activation: always_on
---

<rule name="workflow-router" version="2.0.0">
  <metadata>
    <category>routing</category>
    <severity>info</severity>
  </metadata>

  <status>Compatibility wrapper. Canonical policy is maintained in modular artifacts.</status>

  <canonical_modules>
    <module file="Workflows/task-router.md" />
    <module file="Rules/GEMINI.md" />
  </canonical_modules>
</rule>