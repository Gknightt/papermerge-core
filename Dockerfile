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

# Set environment variables required for Papermerge (use Railway env vars)
ENV PAPERMERGE__DATABASE__URL=$PAPERMERGE__DATABASE__URL
ENV PAPERMERGE__MAIN__MEDIA_ROOT=$PAPERMERGE__MAIN__MEDIA_ROOT
ENV PAPERMERGE__MAIN__API_PREFIX=$PAPERMERGE__MAIN__API_PREFIX

# Expose port 8000
EXPOSE 8000

# Run the Papermerge backend server using poetry task runner
CMD ["poetry", "run", "task", "server"]
