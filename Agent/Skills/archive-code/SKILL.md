---
name: archive-code
description: |
  Create and inspect SCIP code indices for project archives. Use when you need
  precise symbol/navigation data for a codebase snapshot and want the index
  stored with the same project context for later retrieval.
---

<skill name="archive-code" version="2.0.0">
  <metadata>
    <keywords>archive, code-index, scip, symbols, navigation, sourcegraph</keywords>
  </metadata>

  <goal>Generate portable SCIP indices that preserve symbol-level code navigation context.</goal>

  <core_principles>
    <principle name="Project-Root Storage Consistency">
      <rule>Store indices under [PROJECT_PATH]/Agent-Context/Archives/code-index.</rule>
      <rule>Use the same project root for index generation and index viewing.</rule>
    </principle>

    <principle name="Language-Specific Indexers">
      <rule>Use index-ts.ps1 for TypeScript/JavaScript repositories.</rule>
      <rule>Use index-py.ps1 for Python repositories.</rule>
    </principle>

    <principle name="Inspectability">
      <rule>Verify generated .scip files with view-index.ps1 before relying on them.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Confirm Prerequisites">
      <command>npm install -g @sourcegraph/scip-typescript</command>
      <command>pip install scip-python</command>
      <note>Install only the indexer(s) required for the target language.</note>
    </step>

    <step number="2" name="Generate Index">
      <command>.\Agent\Skills\archive-code\scripts\index-ts.ps1 -ProjectPath "[PROJECT_PATH]"</command>
      <command>.\Agent\Skills\archive-code\scripts\index-py.ps1 -ProjectPath "[PROJECT_PATH]"</command>
      <output>[PROJECT_PATH]\Agent-Context\Archives\code-index\[PROJECT_NAME].scip</output>
    </step>

    <step number="3" name="Inspect Index">
      <command>.\Agent\Skills\archive-code\scripts\view-index.ps1 -ProjectPath "[PROJECT_PATH]" -ProjectName "[PROJECT_NAME]"</command>
      <command>.\Agent\Skills\archive-code\scripts\view-index.ps1 -ProjectPath "[PROJECT_PATH]" -ProjectName "[PROJECT_NAME]" -Json</command>
    </step>

    <step number="4" name="Record Archive Metadata">
      <instruction>Capture project name, language, and index timestamp in archive notes.</instruction>
    </step>
  </workflow>

  <resources>
    <script file="scripts/index-ts.ps1">TypeScript/JavaScript SCIP index generation.</script>
    <script file="scripts/index-py.ps1">Python SCIP index generation.</script>
    <script file="scripts/view-index.ps1">SCIP index inspection and JSON export.</script>
  </resources>

  <best_practices>
    <do>Regenerate indices after major refactors or API surface changes</do>
    <do>Keep project names stable for predictable archive retrieval</do>
    <do>Validate index existence and readability before archiving</do>
    <dont>Mix indices from different project roots under one archive name</dont>
    <dont>Assume index freshness without checking generation date</dont>
  </best_practices>

  <related_skills>
    <skill>archive-manager</skill>
    <skill>archive-graph</skill>
    <skill>archive-git</skill>
  </related_skills>
</skill>
