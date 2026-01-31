---
name: workflow-router
description: |
  Maps task triggers to appropriate workflows. Determines when to delegate
  to specialized workflows instead of handling tasks directly.
activation: always_on
---

<rule name="workflow-router" version="1.0.0">
  <metadata>
    <category>routing</category>
    <severity>info</severity>
  </metadata>

  <goal>Route tasks to the most appropriate workflow based on context.</goal>

  <instruction>Delegate complex tasks to the appropriate Workflow:</instruction>

  <routing_table>
    <route trigger="Planning/Design" workflow="/architect" />
    <route trigger="Debugging/Issues" workflow="/analyze" />
    <route trigger="Surgical Debugging" workflow="/debug-step" />
    <route trigger="Implementation" workflow="/code" />
    <route trigger="Researching" workflow="/research" />
    <route trigger="Learning/Docs" workflow="/tutor" />
    <route trigger="Project Setup" workflow="/project-setup" />
    <route trigger="Indexing/Cleanup" workflow="/archive" />
    <route trigger="Refactoring" workflow="/refactor" />
    <route trigger="Pull Request" workflow="/pr" />
    <route trigger="Testing/TDD" workflow="/test-developer" />
    <route trigger="Security Audit" workflow="/security-audit" />
    <route trigger="Fix Issue" workflow="/fix-issue" />
    <route trigger="Handoff" workflow="/handoff" />
    <route trigger="Morning Routine" workflow="/morning" />
    <route trigger="New Codebase" workflow="/onboard" />
    <route trigger="Dependency Check" workflow="/dependency-check" />
    <route trigger="Deployment" workflow="/deploy" />
    <route trigger="Performance Optimization" workflow="/performance-tune" />
  </routing_table>

  <decision_logic>
    <rule>If task matches a trigger, suggest that workflow before proceeding</rule>
    <rule>User may decline workflow and proceed with direct implementation</rule>
    <rule>Always explain why a workflow was suggested</rule>
  </decision_logic>
</rule>
