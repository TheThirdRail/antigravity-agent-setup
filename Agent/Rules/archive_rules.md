---
name: archive-rules
description: |
  Automatic archiving and context retrieval for codebase understanding.
  Ensures agent queries databases before analysis and archives after writes.
activation: always_on
---

<rule name="archive-rules" version="1.0.0">
  <metadata>
    <category>context</category>
    <severity>error</severity>
  </metadata>

  <goal>Maintain persistent AI context through automatic database operations.</goal>

  <behavior name="query-before-analysis">
    <description>Before analyzing, planning, or designing, query archive databases for context.</description>
    <triggers>
      <trigger>Starting /analyze workflow</trigger>
      <trigger>Starting /architect workflow</trigger>
      <trigger>Starting /research workflow (for existing codebase)</trigger>
      <trigger>Starting /refactor workflow</trigger>
      <trigger>Planning any feature that touches existing code</trigger>
    </triggers>
    <actions>
      <action database="mem0">Query for architectural decisions, file purposes, past context</action>
      <action database="codegraph">Query for call graphs, dependencies, inheritance</action>
      <action database="ragdocs">Query for relevant documentation and docstrings</action>
      <action database="git">Query recent commits for relevant changes (via git log)</action>
    </actions>
    <rationale>
      Ensures agent understands existing architecture and decisions before making changes.
      Prevents hallucinations by grounding in actual codebase state.
    </rationale>
  </behavior>

  <behavior name="archive-after-write">
    <description>After writing code to tracked files, update archive databases.</description>
    <triggers>
      <trigger>After writing to any file NOT in .gitignore</trigger>
      <trigger>After creating a new source file</trigger>
      <trigger>After significant refactoring</trigger>
    </triggers>
    <actions>
      <action database="mem0">Store new file purpose, key functions, architectural notes</action>
      <action database="codegraph">Update call graph and dependency relationships</action>
    </actions>
    <exclusions>
      <exclude>Files in Agent-Context/ (already gitignored)</exclude>
      <exclude>Temporary or generated files</exclude>
      <exclude>Test fixtures and mock data</exclude>
    </exclusions>
    <rationale>
      Keeps archive incrementally up-to-date without requiring manual workflow invocation.
      Ensures future sessions have accurate context about recent changes.
    </rationale>
  </behavior>

  <database_reference>
    <database name="mem0" purpose="Knowledge Graph">
      <stores>Architectural decisions, file purposes, user preferences</stores>
      <query_for>Understanding WHY code exists</query_for>
    </database>
    <database name="codegraph" purpose="Structural Graph">
      <stores>Call graphs, dependencies, inheritance hierarchies</stores>
      <query_for>Impact analysis, finding usages, understanding relationships</query_for>
    </database>
    <database name="ragdocs" purpose="Documentation Vector DB">
      <stores>README, docstrings, code comments, API docs</stores>
      <query_for>How-to questions, API usage, setup instructions</query_for>
    </database>
    <database name="git" purpose="Temporal History">
      <stores>Commit history, diffs, blame information</stores>
      <query_for>When/why code changed, root cause analysis</query_for>
    </database>
  </database_reference>

  <constraints>
    <must>Query at least mem0 and codegraph before architectural decisions</must>
    <must>Archive changes within the same session they are made</must>
    <should>Log when archiving to provide transparency to user</should>
    <should_not>Archive to databases when running in read-only mode</should_not>
  </constraints>

  <related_rules>
    <rule>workflow_router</rule>
    <rule>code_standards</rule>
  </related_rules>
</rule>
