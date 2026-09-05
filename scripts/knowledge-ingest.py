import os
import glob
import chromadb
from chromadb.utils import embedding_functions
from pathlib import Path

# Configuration
KNOWLEDGE_DIR = "knowledge"
CHROMA_HOST = "localhost"
CHROMA_PORT = 8000
COLLECTION_NAME = "lyra_knowledge"

def ingest_knowledge():
    # Initialize Chroma client (HTTP for the container)
    client = chromadb.HttpClient(host=CHROMA_HOST, port=CHROMA_PORT)
    
    # Use a lightweight local embedding function
    emb_fn = embedding_functions.DefaultEmbeddingFunction()
    
    collection = client.get_or_create_collection(
        name=COLLECTION_NAME, 
        embedding_function=emb_fn
    )

    # Find all markdown files in knowledge directory
    files = glob.glob(f"{KNOWLEDGE_DIR}/**/*.md", recursive=True)
    print(f"Found {len(files)} files to ingest.")

    for file_path in files:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Simple chunking by double newline (paragraphs)
        chunks = [c.strip() for c in content.split('\\n\\n') if c.strip()]
        
        # Prepare metadata and IDs
        ids = [f"{file_path}_{i}" for i in range(len(chunks))]
        metadatas = [{"source": file_path, "chunk": i} for i in range(len(chunks))]
        
        collection.upsert(
            documents=chunks,
            metadatas=metadatas,
            ids=ids
        )
        print(f"Ingested {len(chunks)} chunks from {file_path}")

if __name__ == "__main__":
    try:
        ingest_knowledge()
        print("Successfully ingested knowledge into ChromaDB.")
    except Exception as e:
        print(f"Error during ingestion: {e}")
        exit(1)
