---
name: wf-analyze
description: |
  OpenAI Codex orchestration skill converted from `analyze.md`.
  Use when Encountering a bug or error; Something isn't working as expected; Need to diagnose a problem before fixing.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-analyze" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, analyze, openai, codex</keywords>
    <source_workflow>analyze.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-analyze</id>
    <name>wf-analyze</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Analyze Mode - Debug issues and diagnose problems with maximum reasoning depth</purpose>
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

  <goal>Analyze Mode - Debug issues and diagnose problems with maximum reasoning depth</goal>

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
    <principle name="Source Constraints">
      <rule>DO NOT write implementation code in this workflow</rule>
      <rule>DO NOT modify source files (read-only diagnosis)</rule>
      <rule>Focus ONLY on diagnosing the root cause</rule>
      <rule>Switch to /fix-issue to apply fixes</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Assess the Issue">
      <instruction>Proceed directly to research Restate the issue and ask "Is this correct?" before proceeding</instruction>
    </step>
    <step number="2" name="Research and Gather Context">
      <instruction>Use for documentation and code examples Use if diagnosing performance issues File search and code inspection Web search for similar issues Log analysis Error message research Check relevant documentation</instruction>
    </step>
    <step number="3" name="Hypothesize Causes">
      <instruction>Generate a ranked list of possible causes from most to least likely ## Analysis Report **Issue:** [One-sentence summary] ### Possible Causes (Ranked) 1. **[Most Likely]** — [Why] — [How to verify] — [Suggested fix] 2. **[Next Most Likely...</instruction>
    </step>
    <step number="4" name="Recommend Next Steps">
      <instruction>Provide a clear diagnostic plan Recommend switching to /fix-issue to implement the fix If multiple approaches exist, ask user preference</instruction>
    </step>
    <step number="5" name="Prepare for Verification">
      <instruction>Define how the fix should be verified Suggest test cases to run Confirm readiness to switch workflows</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `performance-analyzer` when that capability is required.</do>
    <do>Invoke related skill `research-capability` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>performance-analyzer</skill>
    <skill>research-capability</skill>
  </related_skills>
</skill>

