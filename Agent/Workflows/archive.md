---
description: Archive Mode - Index the project to databases for AI context preservation
---

<workflow name="archive" thinking="Normal">
  <purpose>Archive the current project state to databases for persistent AI context.</purpose>

  <when_to_use>
    <trigger>After completing a major feature or milestone</trigger>
    <trigger>Before taking a break from the project</trigger>
    <trigger>To ensure AI has context in future sessions</trigger>
    <trigger>After significant refactoring</trigger>
  </when_to_use>

  <recommended_mcp>
    <server>mem0</server>
    <server>codegraph</server>
    <server>serena</server>
  </recommended_mcp>

  <databases>
    <database name="mem0" alias="memory">Function signatures, file purposes, architectural decisions</database>
    <database name="codegraph">Code relationships, call graphs, dependencies</database>
    <database name="ragdocs">Documentation, comments, README content</database>
  </databases>

  <steps>
    <step number="1" name="Gather Project Information">
      <tool>serena (semantic_search, file_summary)</tool>
      <collect>All source file paths and their purposes</collect>
      <collect>Key function/class signatures (use Serena to extract)</collect>
      <collect>Architectural decisions made</collect>
      <collect>Dependencies and their roles</collect>
      <collect>Important patterns used</collect>
    </step>

    <step number="2" name="Archive to mem0/memory">
      <store>Project name and purpose</store>
      <store>Tech stack used</store>
      <store>Key files and their roles</store>
      <store>Important functions with signatures</store>
      <store>Architectural patterns</store>
      <store>Non-obvious decisions and WHY</store>
    </step>

    <step number="3" name="Archive to codegraph">
      <store>File dependency graph</store>
      <store>Function call relationships</store>
      <store>Class inheritance hierarchies</store>
      <store>Import/export maps</store>
    </step>

    <step number="4" name="Archive to ragdocs">
      <store>README content</store>
      <store>Code comments</store>
      <store>Docstrings</store>
      <store>API documentation</store>
      <store>Setup instructions</store>
    </step>

    <step number="5" name="Verify Archive">
      <action>Query each database to confirm data was stored</action>
      <action>Test a sample retrieval</action>
      <action>Note any failures for retry</action>
    </step>
  </steps>

  <exit_criteria>
    <criterion>All 3 databases updated</criterion>
    <criterion>Verification queries succeed</criterion>
    <criterion>Summary provided to user</criterion>
  </exit_criteria>
</workflow>
