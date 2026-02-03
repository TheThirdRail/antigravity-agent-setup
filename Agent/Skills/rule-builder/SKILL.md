---
name: rule-builder
description: |
  Meta-skill for creating Antigravity agent rules following best practices.
  Guides the process of defining rule structure, activation modes, and
  behavioral constraints. Produces rules in embedded XML-in-markdown format.
  Enforces the 12,000 character limit per rule file.
---

<skill name="rule-builder" version="1.0.0">
  <metadata>
    <keywords>rules, constraints, guardrails, GEMINI.md, agent behavior</keywords>
  </metadata>

  <goal>Guide creation of Antigravity agent rules with proper structure, activation modes, and clear behavioral constraints.</goal>

  <core_principles>
    <principle name="Constraint Clarity">
      <rule>Rules must be unambiguous - no room for interpretation</rule>
      <rule>Use explicit ALLOW/DENY lists where possible</rule>
      <rule>Start with restrictive defaults, then whitelist</rule>
    </principle>

    <principle name="Size Limit">
      <rule>Rule files MUST be under 12,000 characters to respect context limits</rule>
      <rule>Keep rules focused on specific domains (Security, Testing, etc.)</rule>
    </principle>

    <principle name="Activation Specificity">
      <mode name="always_on">Rule is always active</mode>
      <mode name="manual">User must explicitly invoke</mode>
      <mode name="model_decision">Agent decides based on context</mode>
      <mode name="glob">Applies to files matching pattern (e.g., *.ts)</mode>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Define the Rule Purpose">
      <question>What behavior are you constraining or enforcing?</question>
      <question>Is this a MUST, MUST NOT, or PREFER rule?</question>
      <question>Should this apply globally (all projects) or per-workspace?</question>
    </step>

    <step number="2" name="Write Rule File">
      <format>Embedded XML in Markdown (YAML frontmatter + XML body)</format>
      <template><![CDATA[
---

name: rule-name
description: |
  Brief description of what this rule enforces.
  Include WHY this rule exists.
activation: always_on  # or: manual, model_decision, glob
glob: "*.ts"  # only if activation is glob
---

<rule name="rule-name" version="1.0.0">
  <metadata>
    <category>security|code-style|architecture|workflow</category>
    <severity>error|warning|info</severity>
  </metadata>

  <purpose>One sentence explaining what this rule prevents or enforces.</purpose>

  <constraints>
    <must>
      <behavior id="unique-id">Specific mandated behavior</behavior>
    </must>
    <must_not>
      <behavior id="unique-id">Specific prohibited behavior</behavior>
    </must_not>
    <prefer>
      <behavior id="unique-id">Preferred approach</behavior>
    </prefer>
  </constraints>

  <examples>
    <example type="good" description="Correct approach">
      <code>...</code>
    </example>
    <example type="bad" description="What to avoid">
      <code>...</code>
    </example>
  </examples>
</rule>
      ]]></template>
    </step>

    <step number="3" name="Validate Size">
      <instruction>Ensure the file characteristic count is under 12,000.</instruction>
      <check>Is the content focused purely on rules? (Move detailed how-to instructions to Skills)</check>
    </step>

    <step number="4" name="Install Rule">
      <instruction>Move the rule to the appropriate location using helper scripts.</instruction>
      <decision_tree>
        <branch condition="Global Rule (Apply to ALL projects)">
          <action>Run: scripts/move-global-rule.ps1 -Name "rule-name.md"</action>
        </branch>
        <branch condition="Workspace Rule (Apply to THIS project only)">
          <action>Run: scripts/move-local-rule.ps1 -Name "rule-name.md"</action>
        </branch>
      </decision_tree>
    </step>
  </workflow>

  <resource_folders>
    <folder name="scripts/" purpose="Installation utilities">
      <file>move-global-rule.ps1</file>
      <file>move-local-rule.ps1</file>
    </folder>
  </resource_folders>
</skill>
