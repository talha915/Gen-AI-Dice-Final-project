# Gen-AI-Dice-Final-project
Chatbot with Database &amp; Knowledge Base Agents using langgraph and streamlit

A sophisticated chatbot system that allows users to query structured databases and unstructured knowledge bases using natural language.  

The project integrates:

- **Streamlit frontend** for chat interface and file uploads  
- **FastAPI backend** for REST API endpoints  
- **LangGraph workflow** to route queries between database and knowledge base  
- **Chroma vector store** for knowledge base embeddings  
- **SQLite database** for structured queries  

---

## Table of Contents

1. [Project Overview](#project-overview)  
2. [Features](#features)  
3. [Architecture](#architecture)  
4. [Setup Instructions](#setup-instructions)  
5. [Usage](#usage)  
6. [Project Structure](#project-structure)  
7. [FastAPI Backend and Frontend Streamlit](#FastAPI-Backend)  
8. [License](#license)  

---

## Project Overview

This project allows users to ask natural language questions about car data (or other datasets). The system decides if the query should go to:

- **Database Agent** (SQLite DB)  
- **Knowledge Base Agent** (ChromaDB vector store)  

It then returns structured, human-readable summaries.  

---

## Features

### FastAPI Backend

- **`/ingestion-pipeline`**: Ingest documents into Chroma vector database  
- **`/chatbot`**: Query the knowledge base or database via REST API  
- **`/test`**: Health check endpoint  

### Streamlit Frontend

- Chat interface for asking database and KB questions  
- Sidebar for uploading files and monitoring upload progress  
- Maintains session state with chat history  

### Database Agent

- Converts natural language questions to SQL  
- Executes queries on SQLite database (e.g., `used_cars.db`)  
- Returns structured, human-readable summaries  
- Handles query rewriting if errors occur  

### Knowledge Base Agent

- Uses **Chroma vector store** with embeddings from HuggingFace  
- Answers questions based on uploaded documents  
- Provides fallback responses for irrelevant or unanswerable queries  

### Routing Agent

- Determines whether a question should be answered by **Database Agent** or **Knowledge Base Agent**  
- Integrates with LangGraph workflow to handle conditional paths  

---

## Architecture

```bash
User Input (Streamlit Frontend)
          |
          v
    check_relevance node (LangGraph)
          |
  -------------------------------
  |                             |
Database Path                  KB Path
(convert_to_sql)           (ChromaDB + RAG)
  |                             |
execute_sql                  generate_answer
  |                             |
generate_human_readable_answer    |
  |                             |
   END                           END
```

## Node Descriptions

- `check_relevance`: Determines if query should hit DB or KB
- `convert_to_sql`: Converts NL to SQL
- `execute_sql`: Runs SQL query
- `generate_human_readable_answer`: Formats query results
- `regenerate_query`: Handles query rewriting
- `generate_fallback_response`: Handles irrelevant queries
- `knowledge_base`: Handles KB queries
- `end_max_iterations`: Stops workflow after max retries

---

## Setup Instructions

Follow these steps to set up and run the project locally:

### 1. Clone the repository

```bash
git clone https://github.com/talha915/Gen-AI-Dice-Final-project.git
cd Gen-AI-Dice-Final-project
```

## 2. Create and activate virtual environment

```bash
python -m venv venv
source venv/bin/activate   # Linux/macOS
venv\Scripts\activate      # Windows
```

## 3. Install dependencies

```bash
pip install -r requirements.txt
```

## 4. Configure Environment Variables

Create a .env file in the project server folder:
```bash
HUGGINGFACEHUB_API_TOKEN = HUGGINGFACEHUB_API_TOKEN
grok_api_key = grok_api_key
```

## 5. Prepare Database

- Place used_cars.db in the server/db/ folder
- Ensure tables exist with appropriate columns for 

---

## 5. Usage

### Run Streamlit Frontend (in client folder)

```bash
streamlit run main.py 
```

Input queries like:

- "Show all petrol cars manufactured after 2018"
- Upload PDF or DOCX documents in the sidebar to populate the knowledge base

### Run FastAPI Backend (in server folder)
```bash
python run.py
```

---

## 6. Project Structure
```bash
Gen-AI-Dice-Final-project/
├── app/
│   ├── core/
│   │   ├── db_agent.py          # DatabaseAgent class
│   │   ├── kb_query.py          # KnowledgeBase agent using ChromaDB
│   │   └── models.py            # GraphState, structured output classes
│   ├── main.py                  # FastAPI backend
├── db/
│   └── used_cars.db             # SQLite database
├── frontend_app.py              # Streamlit frontend
├── prompts.yaml                 # Prompts for LLMs
├── requirements.txt
└── README.md
```

---

## 7. FastAPI Backend and Frontend Streamlit:

### API endpoints
- /ingestion-pipeline: Ingest documents into Pinecone vector database
- /chatbot: Query KB or database via REST API
- /test: Simple health check endpoint

### Streamlit Frontend
- Chat interface for database & KB questions
- Sidebar for uploading files and monitoring upload progress
- Maintains session state with chat history

---

## 8. License
MIT License

Copyright (c) 2025 Talha Zafar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
