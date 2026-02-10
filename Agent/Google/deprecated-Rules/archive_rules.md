---
name: archive-rules
description: |
  Rules for when and how the agent should archive context locally.
  Ensures consistent usage of archive-memory, archive-docs, archive-code, and archive-graph.
activation: always_on
---

<rule name="archive-rules" version="1.0.0">
  <metadata>
    <category>workflow</category>
    <severity>info</severity>
  </metadata>

  <purpose>Ensure persistent context management through consistent local archiving practices.</purpose>

  <constraints>
    <must>
      <behavior id="memory-decisions">Archive significant architectural decisions to 'decisions' in archive-memory</behavior>
      <behavior id="code-indexing">Index code (archive-code & archive-graph) after major refactors or new features</behavior>
      <behavior id="documentation">Index new documentation (archive-docs) immediately upon creation</behavior>
    </must>
    <must_not>
      <behavior id="no-sensitive-data">Archive credentials or secrets in local databases</behavior>
      <behavior id="no-duplicate-indexing">Re-index unchanged codebases unnecessarily (check timestamps)</behavior>
    </must_not>
    <prefer>
      <behavior id="graph-queries">Use archive-graph for deep dependency questions over simple grep</behavior>
      <behavior id="semantic-search">Use archive-docs for concept search over keyword search</behavior>
    </prefer>
  </constraints>

  <examples>
    <example type="good" description="Archiving a decision">
      <code>python Agent\Skills\archive-memory\scripts\write.py --category "decisions" --key "auth-migration" --value "Switched to JWT for stateless auth"</code>
    </example>
    <example type="bad" description="Forgetting to index new docs">
      <code>(Creating README.md without running archive-docs add script)</code>
    </example>
  </examples>
</rule>
