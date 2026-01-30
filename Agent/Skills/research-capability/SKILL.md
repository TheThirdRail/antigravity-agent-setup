---
name: research-capability
description: |
  Lightweight research capability for contextual information gathering.
  Use when you need to look up documentation, best practices, or current
  solutions during any workflow. Unlike the /research workflow, this skill
  is invoked contextually without producing a formal research artifact.
---

<skill name="research-capability" version="1.0.0">
  <metadata>
    <keywords>research, search, documentation, context7, web-search</keywords>
  </metadata>

  <goal>Gather accurate, current information from multiple sources to inform decisions.</goal>

  <core_principles>
    <principle name="Source Prioritization">
      <priority>1. Official documentation (context7, gitmcp)</priority>
      <priority>2. Recent articles (2024-2025 preferred)</priority>
      <priority>3. GitHub examples and discussions</priority>
      <priority>4. Stack Overflow / community forums</priority>
    </principle>

    <principle name="Recency Matters">
      <rule>Note the date of every source</rule>
      <rule>Flag outdated information explicitly</rule>
      <rule>Prefer "latest" or "current" versions</rule>
    </principle>

    <principle name="Synthesis Over Listing">
      <rule>Don't just list findings — synthesize them</rule>
      <rule>Provide actionable recommendations</rule>
      <rule>Explain trade-offs</rule>
    </principle>
  </core_principles>

  <when_to_use>
    <trigger>Quick lookup during coding workflow</trigger>
    <trigger>Checking best practices for a pattern</trigger>
    <trigger>Fact-checking before decisions</trigger>
    <not_for>Comprehensive pre-implementation research (use context-gatherer)</not_for>
  </when_to_use>

  <recommended_mcp>
    <server>brave-search</server>
    <reason>Private, fast web search for factual lookups</reason>
  </recommended_mcp>

  <workflow>
    <step number="1" name="Identify Research Need">
      <question>What specific information is needed?</question>
      <question>What decisions will this inform?</question>
    </step>

    <step number="2" name="Choose Tools">
      <tool name="context7" use="Library/framework documentation"/>
      <tool name="gitmcp" use="GitHub repository as markdown"/>
      <tool name="augments" use="90+ framework doc sources"/>
      <tool name="searxng/brave/tavily" use="General web search"/>
      <tool name="github" use="Code examples, issue discussions"/>
      <tool name="fetch" use="Deep-read specific URLs"/>
    </step>

    <step number="3" name="Search and Verify">
      <action>Use 2-3 sources for cross-verification</action>
      <action>Check dates on all sources</action>
      <action>Prefer official docs over blog posts</action>
    </step>

    <step number="4" name="Return Findings">
      <format>Brief summary with source links</format>
      <format>Explicit recommendation if applicable</format>
      <note>No formal artifact needed — integrate into current task</note>
    </step>
  </workflow>

  <best_practices>
    <do>Cross-verify facts from multiple sources</do>
    <do>Note dates on all sources</do>
    <do>Prefer official documentation</do>
    <do>Synthesize rather than dump raw results</do>
    <do>Link to sources for traceability</do>
    <dont>Trust single sources for critical decisions</dont>
    <dont>Use outdated Stack Overflow answers without checking</dont>
    <dont>Create formal artifacts for quick lookups</dont>
    <dont>Spend excessive time on tangential research</dont>
  </best_practices>

  <related_skills>
    <skill>architecture-planner</skill>
    <skill>code-reviewer</skill>
  </related_skills>
</skill>
