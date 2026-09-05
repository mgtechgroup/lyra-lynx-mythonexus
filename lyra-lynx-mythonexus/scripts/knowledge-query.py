import os
import sys
import chromadb
from chromadb.utils import embedding_functions

# Configuration
CHROMA_HOST = "localhost"
CHROMA_PORT = 8000
COLLECTION_NAME = "lyra_knowledge"

def query_knowledge(query_text, n_results=3):
    # Initialize Chroma client
    client = chromadb.HttpClient(host=CHROMA_HOST, port=CHROMA_PORT)
    
    # Use the same embedding function as ingestion
    emb_fn = embedding_functions.DefaultEmbeddingFunction()
    
    collection = client.get_collection(
        name=COLLECTION_NAME, 
        embedding_function=emb_fn
    )

    # Query the collection
    results = collection.query(
        query_texts=[query_text],
        n_results=n_results
    )
    
    return results

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python scripts/knowledge-query.py \"your query here\"")
        sys.exit(1)
    
    query = " ".join(sys.argv[1:])
    try:
        res = query_knowledge(query)
        
        print(f"\nQUERY: {query}\n")
        print("TOP RELEVANT KNOWLEDGE SNIPPETS:\n" + "="*30)
        
        # Chroma returns lists of lists for batch queries
        docs = res['documents'][0]
        metadatas = res['metadatas'][0]
        
        for i in range(len(docs)):
            source = metadatas[i].get('source', 'Unknown')
            chunk_id = metadatas[i].get('chunk', 'N/A')
            print(f"[{i+1}] Source: {source} (Chunk {chunk_id})")
            print(f"Content: {docs[i]}")
            print("-" * 30)
            
    except Exception as e:
        print(f"Error querying knowledge: {e}")
        sys.exit(1)
