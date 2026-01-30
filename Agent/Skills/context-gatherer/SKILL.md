---
name: context-gatherer
description: |
  Gather implementation context: code examples, API docs, patterns.
  For quick lookups during coding, use research-capability instead.
---

<skill name="context-gatherer" version="1.0.0">
  <metadata>
    <keywords>context, research, examples, documentation, best-practices, github, libraries</keywords>
  </metadata>

  <resource_folders>
    <folder name="scripts/" purpose="Utility scripts">
      <file>generate-structure.ps1</file>
    </folder>
  </resource_folders>

  <when_to_use>
    <trigger>Need code examples before implementing a feature</trigger>
    <trigger>Researching library/framework usage patterns</trigger>
    <trigger>Understanding API signatures and configurations</trigger>
    <not_for>Quick lookups during coding (use research-capability)</not_for>
  </when_to_use>

  <recommended_mcp>
    <server>serena</server>
    <server>gitmcp</server>
    <server>augments</server>
    <reason>Semantic code search, repo context, and framework docs</reason>
  </recommended_mcp>

  <goal>Gather comprehensive context from documentation and examples to inform implementation.</goal>

  <core_principles>
    <principle name="Source Hierarchy">
      <priority order="1">Official documentation (context7, gitmcp)</priority>
      <priority order="2">Framework/library guides (augments)</priority>
      <priority order="3">GitHub repos with high stars</priority>
      <priority order="4">Recent Stack Overflow answers (2024-2025)</priority>
      <priority order="5">Technical blog posts</priority>
    </principle>

    <principle name="Context Types">
      <type name="Implementation Examples">Working code showing how to do something</type>
      <type name="API Documentation">Function signatures, parameters, return types</type>
      <type name="Best Practices">Recommended patterns, conventions, idioms</type>
      <type name="Anti-Patterns">What NOT to do and why</type>
      <type name="Configuration">Setup, environment, dependencies</type>
    </principle>

    <principle name="Quality Signals">
      <signal good="true">Official docs, verified examples, high GitHub stars</signal>
      <signal good="true">Recent content (2024-2025), active maintenance</signal>
      <signal good="false">Outdated posts, deprecated APIs, low engagement</signal>
    </principle>
  </core_principles>

  <when_to_use>
    <trigger>Before implementing a feature you haven't done before</trigger>
    <trigger>When using a new library or framework</trigger>
    <trigger>Looking for code examples to follow</trigger>
    <trigger>Checking current best practices for a pattern</trigger>
    <trigger>During /architect, /analyze, /code workflows</trigger>
    <trigger>When debugging unfamiliar code</trigger>
  </when_to_use>

  <tools>
    <category name="Documentation MCPs">
      <tool name="context7">
        <purpose>Get up-to-date library/framework documentation</purpose>
        <use_when>Need API details for a specific library</use_when>
        <example>Get React hooks documentation, Express.js middleware API</example>
      </tool>
      <tool name="gitmcp">
        <purpose>Convert GitHub repos to readable markdown</purpose>
        <use_when>Need to understand a library's source code</use_when>
        <example>Read implementation of a popular utility library</example>
      </tool>
      <tool name="augments">
        <purpose>Access 90+ framework documentation sources</purpose>
        <use_when>Need comprehensive framework guides</use_when>
        <example>Next.js routing, Django models, FastAPI dependencies</example>
      </tool>
    </category>

    <category name="Code Search">
      <tool name="github">
        <purpose>Find code examples, popular repos, issue discussions</purpose>
        <use_when>Looking for real-world implementations</use_when>
        <queries>
          <query type="examples">"[pattern] language:typescript stars:>100"</query>
          <query type="usage">"import [library]" filename:*.ts</query>
          <query type="config">"[tool].config" filename:*.json</query>
        </queries>
      </tool>
      <tool name="searxng">
        <purpose>Meta-search across multiple engines</purpose>
        <use_when>Need broad search results</use_when>
      </tool>
    </category>

    <category name="Deep Reading">
      <tool name="fetch">
        <purpose>Read specific URLs for full content</purpose>
        <use_when>Found a relevant page, need details</use_when>
      </tool>
      <tool name="sequential-thinking">
        <purpose>Reason through complex problems step by step</purpose>
        <use_when>Need to analyze gathered information</use_when>
      </tool>
    </category>
  </tools>

  <workflow>
    <step number="1" name="Identify Context Need">
      <question>What am I trying to implement?</question>
      <question>What library/framework am I using?</question>
      <question>What specific API or pattern do I need?</question>
    </step>

    <step number="2" name="Check Official Docs First">
      <action>Use context7 for library documentation</action>
      <action>Use augments for framework guides</action>
      <action>Check official GitHub repo README</action>
    </step>

    <step number="3" name="Find Code Examples">
      <action>Search GitHub for real implementations</action>
      <action>Look for repos with similar use cases</action>
      <action>Find test files showing expected usage</action>
    </step>

    <step number="4" name="Verify Best Practices">
      <action>Cross-reference multiple sources</action>
      <action>Check for recent updates (2024-2025 preferred)</action>
      <action>Look for anti-patterns to avoid</action>
    </step>

    <step number="5" name="Synthesize and Apply">
      <action>Combine findings into actionable guidance</action>
      <action>Note any trade-offs or alternatives</action>
      <action>Apply to current implementation</action>
    </step>
  </workflow>

  <query_patterns>
    <pattern name="API Usage">
      <context7>"[library] [function] usage"</context7>
      <github>"[function](" language:[lang] stars:>50</github>
    </pattern>
    <pattern name="Best Practices">
      <search>"[topic] best practices 2024"</search>
      <github>"[pattern]" language:[lang] stars:>500</github>
    </pattern>
    <pattern name="Configuration">
      <github>"[tool].config" OR "[tool]rc" filename:*.json</github>
      <search>"[tool] configuration guide"</search>
    </pattern>
    <pattern name="Error Solutions">
      <search>"[error message]" site:stackoverflow.com</search>
      <github>issues: "[error message]"</github>
    </pattern>
  </query_patterns>

  <best_practices>
    <do>Start with official documentation before blogs</do>
    <do>Verify code examples actually run</do>
    <do>Check the date on all sources</do>
    <do>Look for multiple confirming sources</do>
    <do>Note library versions in examples</do>
    <do>Prefer TypeScript examples for JS projects</do>
    <dont>Trust single Stack Overflow answers blindly</dont>
    <dont>Use deprecated API examples</dont>
    <dont>Copy code without understanding it</dont>
    <dont>Ignore security implications</dont>
  </best_practices>

  <integration_points>
    <workflow ref="/architect" step="2">Research Best Practices phase</workflow>
    <workflow ref="/analyze" step="2">Research and Gather Context phase</workflow>
    <workflow ref="/code" step="1">Load Context phase</workflow>
    <workflow ref="/research">Full research workflow for comprehensive investigation</workflow>
    <skill ref="research-capability">For quick contextual lookups</skill>
    <skill ref="architecture-planner">For design documentation</skill>
  </integration_points>

  <related_skills>
    <skill>research-capability</skill>
    <skill>architecture-planner</skill>
    <skill>code-reviewer</skill>
    <skill>api-builder</skill>
  </related_skills>
</skill>
