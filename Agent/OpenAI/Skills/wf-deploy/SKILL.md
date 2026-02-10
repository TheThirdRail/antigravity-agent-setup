---
name: wf-deploy
description: |
  OpenAI Codex orchestration skill converted from `deploy.md`.
  Use when Deploying to staging or production; Releasing a new version; Rolling out critical fixes.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-deploy" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, deploy, openai, codex</keywords>
    <source_workflow>deploy.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-deploy</id>
    <name>wf-deploy</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Safe deployment workflow with verification and rollback</purpose>
    <inputs>
      <input>User request and relevant project context.</input>
    </inputs>
    <outputs>
      <output>Completed guidance, actions, or artifacts produced by this skill.</output>
    </outputs>
    <triggers>
      <trigger>Use when the frontmatter description conditions are met.</trigger>
    </triggers>
    <procedure>Follow the ordered steps in the workflow section.</procedure>
    <edge_cases>
      <edge_case>If required context is missing, gather or request it before continuing.</edge_case>
    </edge_cases>
    <safety_constraints>
      <constraint>Avoid destructive operations without explicit user intent.</constraint>
    </safety_constraints>
    <examples>
      <example>Activate this skill when the request matches its trigger conditions.</example>
    </examples>
  </spec_contract>

  <goal>Safe deployment workflow with verification and rollback</goal>

  <core_principles>
    <principle name="Orchestrate First">
      <rule>Act as an orchestration skill: sequence actions, call specialized skills, and keep task focus.</rule>
    </principle>
    <principle name="Deterministic Flow">
      <rule>Follow the ordered step flow from the source workflow unless constraints require adaptation.</rule>
    </principle>
    <principle name="Validation Before Completion">
      <rule>Require verification checks before marking the workflow complete.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Pre-Deployment Checklist">
      <instruction>Verify all prerequisites before deployment All tests passing Security audit clear (/security-audit) Dependencies up to date (/dependency-check) Database migrations prepared and tested Environment variables configured Feature flags set ap...</instruction>
    </step>
    <step number="2" name="Prepare Deployment Artifacts">
      <instruction>Build and validate deployment package Build production artifacts Verify build output (no warnings, correct size) Run smoke tests against build</instruction>
    </step>
    <step number="3" name="Create Backup Point">
      <instruction>Ensure rollback capability Tag current production state (git tag) Backup database if schema changes Document rollback procedure</instruction>
    </step>
    <step number="4" name="Choose Deployment Strategy">
      <instruction>Select appropriate deployment method Low-traffic application, non-critical updates Brief Zero-downtime required, two environments available None (instant switch) Risky changes, need gradual rollout None (gradual switch) Multiple instance...</instruction>
    </step>
    <step number="5" name="Execute Deployment">
      <instruction>Deploy to target environment Run deployment command Watch for deployment errors Verify deployment completes successfully Schedule during low-traffic window if possible</instruction>
    </step>
    <step number="6" name="Post-Deployment Verification">
      <instruction>Verify deployment success Health endpoints responding Smoke tests passing Key user flows working No new errors in logs Performance metrics normal</instruction>
    </step>
    <step number="7" name="Monitor">
      <instruction>Watch for issues after deployment Monitor closely for 30-60 minutes Error rate spikes Response time increases Memory leaks User-reported issues</instruction>
    </step>
    <step number="8" name="Document Deployment">
      <instruction>Record deployment details What was deployed (version, commit) When and by whom Any issues encountered Rollback procedure if needed</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
  </related_skills>
</skill>
