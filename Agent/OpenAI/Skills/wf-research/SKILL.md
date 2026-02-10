---
name: wf-research
description: |
  OpenAI Codex orchestration skill converted from `research.md`.
  Use when Researching best practices for a tech stack; Finding current solutions to technical problems; Comparing frameworks, libraries, or approaches.
  Routes to specialized skills and preserves the original execution sequence.
---

<skill name="wf-research" version="1.0.0">
  <metadata>
    <keywords>workflow, orchestration, research, openai, codex</keywords>
    <source_workflow>research.md</source_workflow>
  </metadata>

  <spec_contract>
    <id>wf-research</id>
    <name>wf-research</name>
    <version>1.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Research Mode - Deep research with maximum thinking using all search tools</purpose>
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

  <goal>Research Mode - Deep research with maximum thinking using all search tools</goal>

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
      <rule>DO NOT write implementation code</rule>
      <rule>DO NOT edit source files</rule>
      <rule>Focus ONLY on information gathering and synthesis</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Clarify the Research Topic">
      <instruction>What specific topic to research? What decisions need to be made? Any constraints (free only, specific language, etc.)?</instruction>
    </step>
    <step number="2" name="Verify Product Lifecycle &amp; Status">
      <instruction>Search for "[Topic] release history [Current Year]" and "[Topic] status" Identify the "Newest Official Source" and "Newest Credible Third-Party Source" Compare dates: If Official is significantly older than Credible, investigate discrepa...</instruction>
    </step>
    <step number="3" name="Use ALL Search Tools">
      <instruction>Use for documentation and code examples Meta-search across multiple engines Web search with privacy AI-optimized search Code examples, popular repos Read specific URLs for deep content</instruction>
    </step>
    <step number="4" name="Use Context MCPs for Code Research">
      <instruction>Get up-to-date library documentation Convert GitHub repos to markdown Access 90+ framework documentation sources</instruction>
    </step>
    <step number="5" name="Prioritize Recent Sources">
      <instruction>Prefer sources from 2024-2025 Note the date of each source Flag any outdated information Look for "latest" or "current" versions</instruction>
    </step>
    <step number="6" name="Research Areas to Cover">
      <instruction>Current best practices, popular libraries, performance, security, community support Common solutions, edge cases, real-world examples</instruction>
    </step>
    <step number="7" name="Document Findings">
      <instruction># [Topic] Research **Date:** [Today's date] **Purpose:** [Why this research was needed] ## Executive Summary [2-3 sentence summary] ## Key Findings ### Best Practices (2024-2025) - [Finding 1] — Source: [URL] ### Recommended Approach [Yo...</instruction>
    </step>
    <step number="8" name="Synthesize and Recommend">
      <instruction>Don't just list findings — synthesize them Provide a clear recommendation Explain WHY you recommend it Note any trade-offs</instruction>
    </step>
  </workflow>

  <best_practices>
    <do>Summarize progress after each major phase when the task is long-running.</do>
    <do>Use specialized skills where referenced for domain-specific quality.</do>
    <do>Invoke related skill `research-capability` when that capability is required.</do>
    <dont>Skip validation or testing steps when the workflow defines them.</dont>
    <dont>Expand scope beyond the workflow objective without explicit user direction.</dont>
  </best_practices>

  <related_skills>
    <skill>research-capability</skill>
  </related_skills>
</skill>
