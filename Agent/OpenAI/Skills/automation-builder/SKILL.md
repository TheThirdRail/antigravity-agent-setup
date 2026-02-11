---
name: automation-builder
description: |
  Build and maintain OpenAI Codex automation templates with clear schedule metadata
  and explicit skill invocation. Use when creating recurring automations, converting
  repeated workflows into automation templates, or updating existing automation files.
---

<skill name="automation-builder" version="1.0.0">
  <metadata>
    <keywords>automation, codex, schedules, templates, openai, recurring</keywords>
  </metadata>

  <spec_contract>
    <id>automation-builder</id>
    <name>automation-builder</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Create and update OpenAI-compatible automation templates that call skills deterministically.</purpose>
    <inputs>
      <input>Recurring task objective, frequency, trigger conditions, and target skills.</input>
    </inputs>
    <outputs>
      <output>Automation template markdown files and updated usage notes.</output>
    </outputs>
    <triggers>
      <trigger>Use when recurring tasks should be captured as Codex automation templates.</trigger>
    </triggers>
    <procedure>Define the recurring intent, map to skills, generate template, and validate schedule metadata.</procedure>
    <edge_cases>
      <edge_case>If recurrence is unclear, default to manual trigger and document assumptions.</edge_case>
    </edge_cases>
    <safety_constraints>
      <constraint>Avoid automations that imply destructive actions without explicit confirmation steps.</constraint>
    </safety_constraints>
    <examples>
      <example>Create weekly dependency-check and security-audit automation templates that invoke wf-* skills.</example>
    </examples>
  </spec_contract>

  <goal>Create reliable Codex automation templates for recurring tasks using explicit skill routing and schedule hints.</goal>

  <core_principles>
    <principle name="Skill-First Automation">
      <rule>Automation templates should invoke skills (`$skill-name`) rather than duplicating full procedures.</rule>
    </principle>
    <principle name="Deterministic Template Layout">
      <rule>Use consistent field order and wording so template diffs remain small and reviewable.</rule>
    </principle>
    <principle name="Safe Recurrence Defaults">
      <rule>Prefer conservative schedules when confidence is low (manual or weekly over aggressive cadence).</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Capture Automation Intent">
      <instruction>Define objective, expected output, trigger cadence, and owner expectations.</instruction>
    </step>
    <step number="2" name="Map Task To Skills">
      <instruction>Select one primary skill and optional supporting skills for each automation template.</instruction>
    </step>
    <step number="3" name="Draft Template Content">
      <instruction>Write markdown template that includes prompt context, explicit skill call, and completion criteria.</instruction>
    </step>
    <step number="4" name="Attach Schedule Metadata">
      <instruction>Set clear schedule hints (daily, weekly, monthly, event-based, manual) in deterministic format.</instruction>
    </step>
    <step number="5" name="Place Output">
      <instruction>Write templates under `Agent/OpenAI/Automations/` using stable names.</instruction>
    </step>
    <step number="6" name="Validate Consistency">
      <instruction>Ensure referenced skills exist and template scope matches intended recurrence.</instruction>
    </step>
    <step number="7" name="Install Automation">
      <instruction>Move the automation template to the appropriate location.</instruction>
      <decision_tree>
        <branch condition="Global Automation (apply across projects)">
          <action>Run: scripts/move-global-automation.ps1 -Name "wf-name.automation.md" -Vendor "openai|anthropic|google"</action>
        </branch>
        <branch condition="Workspace Automation (apply to current project)">
          <action>Run: scripts/move-local-automation.ps1 -Name "wf-name.automation.md" -Vendor "mine|openai|anthropic|google"</action>
        </branch>
      </decision_tree>
    </step>
  </workflow>

  <resource_folders>
    <folder name="scripts/" purpose="Automation installation utilities">
      <file>move-global-automation.ps1</file>
      <file>move-local-automation.ps1</file>
    </folder>
  </resource_folders>

  <best_practices>
    <do>Keep each automation template focused on one recurring job.</do>
    <do>Use explicit `$skill-name` calls in template instructions.</do>
    <do>Document manual fallback for tasks with uncertain cadence.</do>
    <dont>Embed large workflow logic directly in automation files.</dont>
    <dont>Create schedules that trigger expensive tasks unnecessarily often.</dont>
  </best_practices>

  <related_skills>
    <skill>workflow-builder</skill>
    <skill>skill-builder</skill>
    <skill>openai-rule-builder</skill>
  </related_skills>
</skill>
