---
name: archive-docs
description: |
  Embed and search documents semantically using ChromaDB.
  Use to store documentation, code explanations, and research
  for retrieval-augmented context.
---

# Archive Docs Skill

Store embeddings in `Agent-Context/Archives/chroma/` for semantic search.

## Prerequisites

```powershell
pip install chromadb sentence-transformers
```

## When to Use

- Indexing project documentation
- Storing code explanations for later retrieval
- Building searchable knowledge base
- Finding related context by meaning (not just keywords)

## Available Scripts

### Add Document

```powershell
# From project root
python Agent\Skills\archive-docs\scripts\add.py --id "readme-overview" --content "Project overview content..." --metadata '{"source": "README.md"}'
```

### Add from File

```powershell
python Agent\Skills\archive-docs\scripts\add.py --file "docs/architecture.md" --id "architecture"
```

### Search Documents

```powershell
# Semantic search
python Agent\Skills\archive-docs\scripts\search.py --query "how does authentication work" --limit 5
```

### Delete Document

```powershell
python Agent\Skills\archive-docs\scripts\delete.py --id "readme-overview"
```

## Embedding Model

Uses `all-MiniLM-L6-v2` by default (384 dimensions, fast, good quality).

## Storage

Data persisted to `Agent-Context/Archives/chroma/` directory.
