#!/usr/bin/env python3
"""Delete a document from the ChromaDB archive."""

import argparse
import sys
from pathlib import Path

try:
    import chromadb
    from chromadb.config import Settings
except ImportError:
    print(
        "Error: chromadb not installed. Run: pip install chromadb sentence-transformers"
    )
    sys.exit(1)


def get_archive_path():
    """Get the path to the chroma archive directory."""
    script_dir = Path(__file__).parent
    root = script_dir.parent.parent.parent.parent
    return root / "Agent-Context" / "Archives" / "chroma"


def main():
    parser = argparse.ArgumentParser(description="Delete document from archive")
    parser.add_argument("--id", required=True, help="Document ID to delete")
    args = parser.parse_args()

    archive_path = get_archive_path()
    if not archive_path.exists():
        print("No documents archived yet.")
        sys.exit(0)

    client = chromadb.PersistentClient(
        path=str(archive_path), settings=Settings(anonymized_telemetry=False)
    )

    try:
        collection = client.get_collection("documents")
        collection.delete(ids=[args.id])
        print(f"✓ Deleted document: {args.id}")
    except Exception as e:
        print(f"Error deleting: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
