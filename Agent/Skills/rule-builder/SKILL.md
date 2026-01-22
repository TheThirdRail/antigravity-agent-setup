---
name: rule-builder
description: |
  Meta-skill for creating Antigravity agent rules following best practices.
  Guides the process of defining rule structure, activation modes, and
  behavioral constraints. Produces rules in embedded XML-in-markdown format
  compatible with Antigravity's global and workspace rule systems.
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

    <principle name="Layered Hierarchy">
      <level name="Global" location="~/.gemini/GEMINI.md">Applied to all projects</level>
      <level name="Workspace" location=".agent/rules/">Project-specific rules</level>
      <note>Workspace rules override global rules for conflicts</note>
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
      <question>Is this a MUST DO, MUST NOT DO, or PREFER rule?</question>
      <question>Should this apply globally or per-project?</question>
      <question>What activation mode is appropriate?</question>
    </step>

    <step number="2" name="Choose Rule Location">
      <option name="Global Rule">
        <path>~/.gemini/rules/rule-name.md</path>
        <use_when>You want this rule in ALL projects</use_when>
      </option>
      <option name="Workspace Rule">
        <path>.agent/rules/rule-name.md</path>
        <use_when>Rule is project-specific</use_when>
      </option>
    </step>

    <step number="3" name="Write Rule File">
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
    <must>Always do this specific thing</must>
    <must_not>Never do this dangerous thing</must_not>
    <prefer>Prefer this approach when possible</prefer>
  </constraints>

  <examples>
    <good description="Correct approach">
      <code><![CDATA[
// Good example code here
      ]]]]><![CDATA[></code>
    </good>
    <bad description="What to avoid">
      <code><![CDATA[
// Bad example code here
      ]]]]><![CDATA[></code>
    </bad>
  </examples>

  <enforcement>
    <action>How the agent should respond to violations</action>
  </enforcement>
</rule>
      ]]></template>
    </step>

    <step number="4" name="Define Constraints">
      <constraint_types>
        <type name="must">Required behavior - violation is an error</type>
        <type name="must_not">Forbidden behavior - violation is an error</type>
        <type name="prefer">Recommended behavior - violation is a warning</type>
        <type name="avoid">Discouraged behavior - violation is a warning</type>
      </constraint_types>
    </step>

    <step number="5" name="Add Examples">
      <instruction>Provide concrete good/bad examples for each constraint</instruction>
      <instruction>Use code snippets when relevant</instruction>
      <instruction>Explain WHY the bad example is problematic</instruction>
    </step>

    <step number="6" name="Validate and Install">
      <checklist>
        <item>YAML frontmatter is valid</item>
        <item>Activation mode is appropriate</item>
        <item>Constraints are unambiguous</item>
        <item>Examples illustrate each constraint</item>
        <item>Rule doesn't conflict with existing rules</item>
      </checklist>
      <install>Run install-rules.ps1 to install globally</install>
    </step>
  </workflow>

  <common_rule_patterns>
    <pattern name="Security Guardrail">
      <purpose>Prevent dangerous operations</purpose>
      <example_constraints>
        <must_not>Execute rm -rf, force push, or kill commands</must_not>
        <must>Require confirmation for file deletions</must>
      </example_constraints>
    </pattern>

    <pattern name="Code Style Enforcement">
      <purpose>Ensure consistent coding standards</purpose>
      <example_constraints>
        <must>Use TypeScript for all new files</must>
        <prefer>Use functional components over class components</prefer>
      </example_constraints>
    </pattern>

    <pattern name="Architecture Boundary">
      <purpose>Enforce architectural decisions</purpose>
      <example_constraints>
        <must>Place business logic in ViewModels, not Views</must>
        <must_not>Import from internal packages directly</must_not>
      </example_constraints>
    </pattern>

    <pattern name="Skill Enforcement">
      <purpose>Force use of specific skills for certain tasks</purpose>
      <example_constraints>
        <must>Use git-commit-generator skill for all commits</must>
        <must>Use test-generator skill when adding new functions</must>
      </example_constraints>
    </pattern>
  </common_rule_patterns>

  <best_practices>
    <do>Make rules specific and actionable</do>
    <do>Provide concrete examples of compliance</do>
    <do>Explain the reasoning behind restrictions</do>
    <do>Use glob patterns for file-type specific rules</do>
    <do>Test rules in a single project before making global</do>
    <dont>Create overly broad rules that block normal work</dont>
    <dont>Conflict with other rules without explicit priority</dont>
    <dont>Use ambiguous language like "try to" or "sometimes"</dont>
    <dont>Create rules without violation examples</dont>
    <dont>Make all rules always_on - be selective</dont>
  </best_practices>

  <troubleshooting>
    <issue problem="Rule not applied">Check activation mode and file location</issue>
    <issue problem="Rule conflicts">More specific rules should override general ones</issue>
    <issue problem="Agent ignores rule">Rephrase as explicit MUST/MUST_NOT constraint</issue>
    <issue problem="Rule too restrictive">Consider using 'prefer' instead of 'must'</issue>
  </troubleshooting>

  <related_skills>
    <skill>skill-builder</skill>
    <skill>workflow-builder</skill>
  </related_skills>
</skill>
