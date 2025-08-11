FROM python:3.13-slim

ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libmagic1 \
    poppler-utils \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /app

# Copy poetry files first
COPY poetry.lock pyproject.toml /app/

# Copy app source before installing dependencies
COPY . /app

# Install dependencies including current project (no --no-root)
RUN poetry install -E pg

# Copy entrypoint script and make it executable
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose port 8000
EXPOSE 8000

# Use entrypoint script to migrate and start server
ENTRYPOINT ["/app/entrypoint.sh"]
