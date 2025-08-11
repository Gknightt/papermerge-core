FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libmagic1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Start Uvicorn for ASGI
CMD uvicorn docker.__cloud__obsolete.config.asgi:application --host 0.0.0.0 --port 8000
