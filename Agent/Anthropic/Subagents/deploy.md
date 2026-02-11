---
name: deploy
description: |
  Safe deployment workflow with verification and rollback
---

<subagent name="deploy" version="1.0.0">
  <metadata>
    <format>embedded-xml-markdown</format>
    <owner>anthropic</owner>
  </metadata>

  <purpose>Safe deployment workflow with verification and rollback</purpose>

  <when_to_use>
    <trigger>Deploying to staging or production</trigger>
    <trigger>Releasing a new version</trigger>
    <trigger>Rolling out critical fixes</trigger>
  </when_to_use>

  <constraints>
    <rule>Do: Follow repository safety and quality policies.</rule>
  </constraints>

  <workflow>
    <step number="1" name="Pre-Deployment Checklist">
      <action>Verify all prerequisites before deployment</action>
    </step>
    <step number="2" name="Prepare Deployment Artifacts">
      <action>Build and validate deployment package</action>
    </step>
    <step number="3" name="Create Backup Point">
      <action>Ensure rollback capability</action>
    </step>
    <step number="4" name="Choose Deployment Strategy">
      <action>Select appropriate deployment method</action>
    </step>
    <step number="5" name="Execute Deployment">
      <action>Deploy to target environment</action>
    </step>
    <step number="6" name="Post-Deployment Verification">
      <action>Verify deployment success</action>
    </step>
    <step number="7" name="Monitor">
      <action>Watch for issues after deployment</action>
    </step>
    <step number="8" name="Document Deployment">
      <action>Record deployment details</action>
      <action>What was deployed (version, commit) When and by whom Any issues encountered Rollback procedure if needed</action>
    </step>
  </workflow>

  <output_contract>
    <criterion>Application is running the new version</criterion>
    <criterion>All health checks passing</criterion>
    <criterion>No increase in error rates</criterion>
    <criterion>Performance metrics stable</criterion>
  </output_contract>

  <handoffs>
    <route>/dependency-check</route>
    <route>/pr</route>
    <route>/security-audit</route>
  </handoffs>

  <tooling>
    <note>Inherits tools from the parent Claude runtime context.</note>
  </tooling>
</subagent>

