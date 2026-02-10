---
name: archive-docs
description: |
  Store and search project documents semantically with ChromaDB embeddings.
  Use when you need retrieval-ready documentation memory for design notes,
  architecture explanations, runbooks, and long-form references.
---

<skill name="archive-docs" version="2.0.0">
  <metadata>
    <keywords>archive, docs, embeddings, chromadb, semantic-search, knowledge-base</keywords>
  </metadata>

  <spec_contract>
    <id>archive-docs</id>
    <name>archive-docs</name>
    <version>2.0.0</version>
    <last_updated>2026-02-09</last_updated>
    <purpose>Preserve searchable project documentation context using embedding-based retrieval.</purpose>
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

  <goal>Preserve searchable project documentation context using embedding-based retrieval.</goal>

  <core_principles>
    <principle name="Semantic Retrieval Over Keyword-Only Search">
      <rule>Index documents with metadata to support meaning-based lookup.</rule>
      <rule>Use consistent document IDs for stable updates and deletions.</rule>
    </principle>

    <principle name="Traceable Sources">
      <rule>Include metadata like source path, topic, and timestamp when adding documents.</rule>
      <rule>Keep original source text accessible outside the vector store.</rule>
    </principle>

    <principle name="Project-Scoped Persistence">
      <rule>Persist vectors in [PROJECT_PATH]/Agent-Context/Archives/chroma.</rule>
    </principle>
  </core_principles>

  <workflow>
    <step number="1" name="Install Prerequisites">
      <command>pip install chromadb sentence-transformers</command>
    </step>

    <step number="2" name="Add Documents">
      <command>python Agent\OpenAI\Skills\archive-docs\scripts\add.py --id "doc-id" --content "Document text" --metadata "{\"source\":\"docs/architecture.md\"}"</command>
      <command>python Agent\OpenAI\Skills\archive-docs\scripts\add.py --file "docs/architecture.md" --id "architecture"</command>
    </step>

    <step number="3" name="Search Semantically">
      <command>python Agent\OpenAI\Skills\archive-docs\scripts\search.py --query "authentication flow" --limit 5</command>
    </step>

    <step number="4" name="Delete or Replace Stale Entries">
      <command>python Agent\OpenAI\Skills\archive-docs\scripts\delete.py --id "doc-id"</command>
    </step>
  </workflow>

  <resources>
    <script file="scripts/add.py">Add or update archived documentation entries.</script>
    <script file="scripts/search.py">Semantic search over archived documents.</script>
    <script file="scripts/delete.py">Delete archived document entries by ID.</script>
  </resources>

  <best_practices>
    <do>Use deterministic IDs so updates replace the right document</do>
    <do>Attach source metadata for every document entry</do>
    <do>Batch related docs by topic for better retrieval quality</do>
    <dont>Index transient or generated noise files without curation</dont>
    <dont>Rely on embeddings alone when exact command/code matches are required</dont>
  </best_practices>

  <related_skills>
    <skill>archive-manager</skill>
    <skill>research-capability</skill>
    <skill>documentation-generator</skill>
  </related_skills>
</skill>
