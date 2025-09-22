# Gen-AI-Dice-Final-project
Chatbot with Database &amp; Knowledge Base Agents using langgraph and streamlit

A sophisticated chatbot system that allows users to query car data using natural language. The project integrates a **Streamlit frontend** with a **LangGraph-based workflow backend**, capable of answering queries via a **database** or a **knowledge base (RAG)**.

---

## Table of Contents

1. [Project Overview](#project-overview)  
2. [Features](#features)  
3. [Architecture](#architecture)  
4. [Setup Instructions](#setup-instructions)  
5. [Usage](#usage)  
6. [Project Structure](#project-structure)  
7. [Contributing](#contributing)  
8. [License](#license)  

---

## Project Overview

This project allows users to ask questions in natural language about used cars. The system determines whether the query is **relevant to the database** or should be handled via a **knowledge base**. It supports:

- Translating natural language queries into SQL
- Executing queries on a SQLite database
- Generating human-readable, executive-friendly summaries
- Rewriting queries for better results
- Handling irrelevant queries via a fallback or knowledge base

The frontend is built using **Streamlit**, while the backend leverages **LangGraph** and **LangChain Groq LLMs** for decision-making and SQL generation.

---

## Features

- **Database Querying**
  - Converts natural language queries to SQL
  - Executes SQL queries on a SQLite database
  - Automatic query rewriting in case of errors

- **Knowledge Base Support**
  - Queries answered from a RAG-based knowledge base if DB is irrelevant

- **Fallback and Error Handling**
  - Provides fallback messages for irrelevant or unanswerable queries
  - Limits maximum retry attempts

- **Human-Readable Summaries**
  - Converts raw SQL results into concise, readable answers

- **Frontend**
  - Streamlit interface for easy user interaction

---

## Architecture

```text
User Input (Streamlit Frontend)
          |
          v
    check_relevance node (LangGraph)
          |
  -----------------------
  |                     |
Database Path        Knowledge Base Path
(convert_to_sql)     (RAGQueryEngine)
  |                     |
execute_sql          generate_answer
  |
generate_human_readable_answer
  |
   END
