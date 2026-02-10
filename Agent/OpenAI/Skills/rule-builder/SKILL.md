---
name: rule-builder
description: |
  Create or update reusable agent behavior rules with explicit constraints,
  activation modes, and install paths. Use when enforcing consistent
  guardrails (security, style, workflow) across a workspace or globally.
---

<skill name="rule-builder" version="2.0.0">
  <metadata>
    <keywords>rules, constraints, guardrails, GEMINI.md, agent behavior</keywords>
  </metadata>

  <spec_contract>
    <id>rule-builder</id>
    <name>rule-builder</name>
    <version>2.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Guide creation of Antigravity agent rules with proper structure, activation modes, and clear behavioral constraints.</purpose>
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

  <spec_contract>
    <id>rule-builder</id>
    <name>rule-builder</name>
    <version>2.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Guide creation of Antigravity agent rules with proper structure, activation modes, and clear behavioral constraints.</purpose>
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
      <instruction>Ensure the file character count is under 12,000.</instruction>
      <check>Is the content focused purely on rules? (Move detailed how-to instructions to Skills)</check>
    </step>

    <step number="4" name="Install Rule">
      <instruction>Move the rule to the appropriate location using helper scripts.</instruction>
      <decision_tree>
        <branch condition="Global Rule (Apply to ALL projects)">
          <action>Run: scripts/move-global-rule.ps1 -Name "rule-name.md" -Vendor "anthropic|openai|google"</action>
        </branch>
        <branch condition="Workspace Rule (Apply to THIS project only)">
          <action>Run: scripts/move-local-rule.ps1 -Name "rule-name.md" -Vendor "mine|anthropic|openai|google"</action>
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

  <best_practices>
    <do>Write constraints in enforceable terms (must, must_not, prefer)</do>
    <do>Keep rule scope narrow and domain-specific</do>
    <do>Install rules using script parameters instead of manual path edits</do>
    <dont>Embed long tutorials or implementation guidance in rule files</dont>
    <dont>Use ambiguous statements that cannot be validated in review</dont>
  </best_practices>
</skill>
