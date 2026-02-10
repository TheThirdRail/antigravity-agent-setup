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
      <command>python Agent\Google\Skills\archive-docs\scripts\add.py --id "doc-id" --content "Document text" --metadata "{\"source\":\"docs/architecture.md\"}"</command>
      <command>python Agent\Google\Skills\archive-docs\scripts\add.py --file "docs/architecture.md" --id "architecture"</command>
    </step>

    <step number="3" name="Search Semantically">
      <command>python Agent\Google\Skills\archive-docs\scripts\search.py --query "authentication flow" --limit 5</command>
    </step>

    <step number="4" name="Delete or Replace Stale Entries">
      <command>python Agent\Google\Skills\archive-docs\scripts\delete.py --id "doc-id"</command>
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
