# Base image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage cache
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend and frontend folders
COPY server/ ./server/
COPY client/ ./client/

# Expose ports
EXPOSE 8000
EXPOSE 8501

# Set environment variables for Streamlit
ENV STREAMLIT_SERVER_PORT=8501
ENV STREAMLIT_SERVER_HEADLESS=true

# Default command: start FastAPI backend and Streamlit frontend
CMD ["sh", "-c", "cd server && python run.py & streamlit run client/main.py --server.port 8501"]

# How has the proportion of petrol vs diesel cars changed from 2018 to 2022?
