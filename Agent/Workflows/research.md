---
description: Research Mode - Deep research with maximum thinking using all search tools
---

<workflow name="research" thinking="MAX">
  <important>Use MAXIMUM thinking/reasoning depth. Prioritize the most up-to-date sources.</important>

  <when_to_use>
    <trigger>Researching best practices for a tech stack</trigger>
    <trigger>Finding current solutions to technical problems</trigger>
    <trigger>Comparing frameworks, libraries, or approaches</trigger>
    <trigger>Gathering information before /architect mode</trigger>
  </when_to_use>

  <recommended_mcp>
    <server>sequential-thinking</server>
    <server>brave-search</server>
    <server>tavily</server>
    <server>firecrawl</server>
    <reason>Deep reasoning and comprehensive web search/scraping</reason>
  </recommended_mcp>

  <output>
    <location>research/</location>
    <format>[topic]-research.md</format>
    <note>The research/ folder should be in .gitignore</note>
  </output>

  <steps>
    <step number="1" name="Clarify the Research Topic">
      <parse>What specific topic to research?</parse>
      <parse>What decisions need to be made?</parse>
      <parse>Any constraints (free only, specific language, etc.)?</parse>
    </step>

    <step number="2" name="Use ALL Search Tools">
      <skill ref="context-gatherer">Use for documentation and code examples</skill>
      <tools category="Web Search">
        <tool name="searxng">Meta-search across multiple engines</tool>
        <tool name="brave-search">Web search with privacy</tool>
        <tool name="tavily">AI-optimized search</tool>
        <tool name="github">Code examples, popular repos</tool>
        <tool name="fetch">Read specific URLs for deep content</tool>
      </tools>
    </step>

    <step number="2b" name="Use Context MCPs for Code Research">
      <tools category="Code Context">
        <tool name="context7">Get up-to-date library documentation</tool>
        <tool name="gitmcp">Convert GitHub repos to markdown</tool>
        <tool name="augments">Access 90+ framework documentation sources</tool>
      </tools>
    </step>

    <step number="3" name="Prioritize Recent Sources">
      <rule>Prefer sources from 2024-2025</rule>
      <rule>Note the date of each source</rule>
      <rule>Flag any outdated information</rule>
      <rule>Look for "latest" or "current" versions</rule>
    </step>

    <step number="4" name="Research Areas to Cover">
      <category name="Tech Stack Research">Current best practices, popular libraries, performance, security, community support</category>
      <category name="Problem-Solving Research">Common solutions, edge cases, real-world examples</category>
    </step>

    <step number="5" name="Document Findings">
      <output_template><![CDATA[
# [Topic] Research

**Date:** [Today's date]
**Purpose:** [Why this research was needed]

## Executive Summary
[2-3 sentence summary]

## Key Findings

### Best Practices (2024-2025)
- [Finding 1] — Source: [URL]

### Recommended Approach
[Your synthesis and recommendation]

### Alternatives Considered
| Option | Pros | Cons |
|--------|------|------|
| [Option 1] | [Pros] | [Cons] |

### Sources
1. [Title](URL) — [Date] — [Brief note]
      ]]></output_template>
    </step>

    <step number="6" name="Synthesize and Recommend">
      <rule>Don't just list findings — synthesize them</rule>
      <rule>Provide a clear recommendation</rule>
      <rule>Explain WHY you recommend it</rule>
      <rule>Note any trade-offs</rule>
    </step>
  </steps>

  <exit_criteria>
    <criterion>Research file created in research/ folder</criterion>
    <criterion>Clear synthesis and recommendation provided</criterion>
    <criterion>Sources documented with dates</criterion>
    <criterion>User understands the findings</criterion>
  </exit_criteria>
</workflow>
