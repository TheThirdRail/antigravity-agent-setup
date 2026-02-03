#!/usr/bin/env python3
"""Add a document to the ChromaDB archive for semantic search."""

import argparse
import json
import os
import sys
from pathlib import Path

try:
    import chromadb
    from chromadb.config import Settings
except ImportError:
    print("Error: chromadb not installed. Run: pip install chromadb sentence-transformers")
    sys.exit(1)

def get_archive_path():
    """Get the path to the chroma archive directory."""
    script_dir = Path(__file__).parent
    root = script_dir.parent.parent.parent.parent
    return root / "Agent-Context" / "Archives" / "chroma"

def main():
    parser = argparse.ArgumentParser(description="Add document to archive")
    parser.add_argument("--id", required=True, help="Unique document ID")
    parser.add_argument("--content", help="Document content (text)")
    parser.add_argument("--file", help="Path to file to read content from")
    parser.add_argument("--metadata", default="{}", help="JSON metadata")
    args = parser.parse_args()

    # Get content
    if args.file:
        file_path = Path(args.file)
        if not file_path.exists():
            print(f"Error: File not found: {args.file}")
            sys.exit(1)
        content = file_path.read_text(encoding="utf-8")
        # Auto-add source metadata
        meta = json.loads(args.metadata)
        meta["source"] = str(file_path)
        args.metadata = json.dumps(meta)
    elif args.content:
        content = args.content
    else:
        print("Error: Must provide --content or --file")
        sys.exit(1)

    # Initialize ChromaDB
    archive_path = get_archive_path()
    archive_path.mkdir(parents=True, exist_ok=True)
    
    client = chromadb.PersistentClient(
        path=str(archive_path),
        settings=Settings(anonymized_telemetry=False)
    )
    
    # Get or create collection
    collection = client.get_or_create_collection(
        name="documents",
        metadata={"hnsw:space": "cosine"}
    )
    
    # Parse metadata
    metadata = json.loads(args.metadata)
    
    # Upsert document
    collection.upsert(
        ids=[args.id],
        documents=[content],
        metadatas=[metadata]
    )
    
    print(f"✓ Added document: {args.id}")
    print(f"  Content length: {len(content)} chars")
    print(f"  Metadata: {metadata}")

if __name__ == "__main__":
    main()
