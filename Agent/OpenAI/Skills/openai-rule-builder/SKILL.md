---
name: openai-rule-builder
description: |
  Create and maintain OpenAI Codex-compatible Starlark command rules in `default.rules`.
  Use when adding, revising, or auditing prefix-based command policies for safety,
  dependency environment enforcement, and network/destructive command prompting.
---

<skill name="openai-rule-builder" version="1.0.0">
  <metadata>
    <keywords>rules, codex, starlark, prefix_rule, safety, openai</keywords>
  </metadata>

  <spec_contract>
    <id>openai-rule-builder</id>
    <name>openai-rule-builder</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Produce valid OpenAI Codex Starlark command policy rules and keep them deterministic.</purpose>
    <inputs>
      <input>Rule intent, command patterns, decision level (allow/prompt/deny), and environment constraints.</input>
    </inputs>
    <outputs>
      <output>Updated `Agent/OpenAI/default.rules` in valid Starlark syntax with ordered policy entries.</output>
    </outputs>
    <triggers>
      <trigger>Use when Codex command policy must be created, corrected, or expanded.</trigger>
    </triggers>
    <procedure>Classify command patterns, emit `prefix_rule(...)` entries, and verify deterministic ordering.</procedure>
    <edge_cases>
      <edge_case>If a command can be destructive, default decision should be `prompt` unless explicitly overridden.</edge_case>
    </edge_cases>
    <safety_constraints>
      <constraint>Do not output XML or markdown as active `.rules` runtime policy syntax.</constraint>
    </safety_constraints>
    <examples>
      <example>Add prompt policy for global package installs across Python, Node, Ruby, .NET, and Rust toolchains.</example>
    </examples>
  </spec_contract>

  <goal>Maintain Codex-compatible Starlark rule files with clear allow/prompt/deny command policies.</goal>

  <core_principles>
    <principle name="Starlark-Only Runtime Syntax">
      <rule>Active OpenAI Codex command rules must use valid `prefix_rule(...)` Starlark syntax.</rule>
    </principle>
    <principle name="Least Privilege Defaults">
      <rule>Unknown or risky commands default to `prompt` rather than `allow`.</rule>
    </principle>
    <principle name="Deterministic Ordering">
      <rule>Group rules by policy domain and keep ordering stable to reduce diff noise.</rule>
    </principle>
    <principle name="Cross-Ecosystem Environment Safety">
      <rule>Dependency management policies must cover multiple ecosystems, not Python only.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Gather Policy Intent">
      <instruction>Identify command families and desired decisions: allow, prompt, or deny.</instruction>
    </step>
    <step number="2" name="Classify Risk Domains">
      <instruction>Split into destructive operations, network operations, and dependency management operations.</instruction>
    </step>
    <step number="3" name="Author Starlark Rules">
      <instruction>Emit one `prefix_rule(pattern=[...], decision=\"...\")` per policy entry with explicit token arrays.</instruction>
    </step>
    <step number="4" name="Normalize Ordering">
      <instruction>Sort rules by domain and then by command pattern for deterministic output.</instruction>
    </step>
    <step number="5" name="Write Canonical File">
      <instruction>Update `Agent/OpenAI/default.rules` as the single active source file.</instruction>
    </step>
    <step number="6" name="Verify Integration">
      <instruction>Run OpenAI installer/validation scripts in dry-run mode to confirm target paths and policy sync.</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Prefer `prompt` for commands with high blast radius.</do>
    <do>Keep comments concise and focused on policy intent.</do>
    <do>Explicitly cover global dependency installs across ecosystems.</do>
    <dont>Use legacy XML blocks as active `.rules` runtime content.</dont>
    <dont>Create overlapping duplicate patterns with conflicting decisions.</dont>
  </best_practices>

  <related_skills>
    <skill>rule-builder</skill>
    <skill>skill-builder</skill>
    <skill>automation-builder</skill>
  </related_skills>
</skill>

