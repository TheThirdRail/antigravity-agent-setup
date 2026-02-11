---
name: archive-code
description: |
  Search and navigate code using ripgrep (grep). Use when you need to find
  definitions, references, or text patterns in the codebase without generating
  a persistent index file.
---

<skill name="archive-code" version="2.1.0">
  <metadata>
    <keywords>archive, code-search, grep, ripgrep, symbols, navigation</keywords>
  </metadata>

  <goal>Provide fast, pattern-based code navigation and search using ripgrep.</goal>

  <core_principles>
    <principle name="Live Search Over Indexing">
      <rule>Do not generate static index files; query the current codebase state directly.</rule>
      <rule>Use ripgrep (rg) for maximum speed and gitignore respect.</rule>
    </principle>

    <principle name="Definition vs Reference">
      <rule>Use --type logic or regex patterns to distinguish definitions from references.</rule>
      <rule>Present results with line numbers and context.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Search Code">
      <command>.\Agent\Anthropic\Skills\archive-code\scripts\search.ps1 -Pattern "class User" -Path "[PROJECT_PATH]"</command>
      <command>.\Agent\Anthropic\Skills\archive-code\scripts\search.ps1 -Pattern "def login" -Path "[PROJECT_PATH]" -Type "definition"</command>
      <command>.\Agent\Anthropic\Skills\archive-code\scripts\search.ps1 -Pattern "auth_service" -Path "[PROJECT_PATH]" -Context 2</command>
    </step>
  </workflow>

  <resources>
    <script file="scripts/search.ps1">PowerShell wrapper for ripgrep searching.</script>
  </resources>

  <best_practices>
    <do>Use specific patterns to narrow down results (e.g. "class Name" vs "Name")</do>
    <do>Use context flags to see surrounding code</do>
    <dont>Search for extremely common tokens (like "id" or "name") without context</dont>
  </best_practices>

  <related_skills>
    <skill>archive-manager</skill>
    <skill>archive-graph</skill>
    <skill>archive-git</skill>
  </related_skills>
</skill>
