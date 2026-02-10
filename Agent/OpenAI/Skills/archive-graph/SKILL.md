---
name: archive-graph
description: |
  Build and query a local structural code graph using Tree-sitter and SQLite.
  Use when you need file/function/class structure context and lightweight
  relationship exploration for impact analysis.
---

<skill name="archive-graph" version="2.0.0">
  <metadata>
    <keywords>archive, graph, tree-sitter, sqlite, structure, impact-analysis</keywords>
  </metadata>

  <spec_contract>
    <id>archive-graph</id>
    <name>archive-graph</name>
    <version>2.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Create and query a project-local structural graph of files and code symbols.</purpose>
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

  <goal>Create and query a project-local structural graph of files and code symbols.</goal>

  <core_principles>
    <principle name="Build Before Query">
      <rule>Run graph build after significant code changes or before deep structural analysis.</rule>
      <rule>Treat graph output as a snapshot of repository state at build time.</rule>
    </principle>

    <principle name="Use Supported Query Modes">
      <rule>Supported query modes are --files, --structure, and --query.</rule>
      <rule>Do not assume unsupported traversal flags unless implemented in scripts/query.py.</rule>
    </principle>

    <principle name="Project-Scoped Persistence">
      <rule>Store graph database at [PROJECT_PATH]/Agent-Context/Archives/graph.db.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Install Prerequisites">
      <command>pip install tree-sitter tree-sitter-languages</command>
    </step>

    <step number="2" name="Build Graph Snapshot">
      <command>python Agent\OpenAI\Skills\archive-graph\scripts\build.py --path "[PROJECT_PATH]"</command>
      <output>[PROJECT_PATH]\Agent-Context\Archives\graph.db</output>
    </step>

    <step number="3" name="Query Available Files">
      <command>python Agent\OpenAI\Skills\archive-graph\scripts\query.py --files --project-path "[PROJECT_PATH]"</command>
    </step>

    <step number="4" name="Inspect File Structure">
      <command>python Agent\OpenAI\Skills\archive-graph\scripts\query.py --structure "auth" --project-path "[PROJECT_PATH]"</command>
    </step>

    <step number="5" name="Search Symbol Names">
      <command>python Agent\OpenAI\Skills\archive-graph\scripts\query.py --query "login" --project-path "[PROJECT_PATH]"</command>
    </step>
  </workflow>

  <resources>
    <script file="scripts/build.py">Parse codebase and materialize graph nodes/edges.</script>
    <script file="scripts/query.py">Run supported graph queries (files, structure, symbol search).</script>
  </resources>

  <best_practices>
    <do>Rebuild graph after refactors to avoid stale symbol locations</do>
    <do>Use symbol search first, then narrow with structure queries</do>
    <do>Pair graph results with archive-git when validating change history</do>
    <dont>Assume unsupported query flags or Cypher-style syntax</dont>
    <dont>Treat graph output as runtime call graph truth</dont>
  </best_practices>

  <related_skills>
    <skill>archive-manager</skill>
    <skill>archive-code</skill>
    <skill>archive-git</skill>
  </related_skills>
</skill>
