# -------------------------------
# 1) Frontend build stage
# -------------------------------
FROM node:20 AS frontend-build

WORKDIR /app

# Copy entire repo (needed for Yarn workspaces)
COPY . .

# Install dependencies for all workspaces
RUN yarn install --frozen-lockfile

# Build the UI workspace
RUN yarn workspace ui build


# -------------------------------
# 2) Backend build stage
# -------------------------------
FROM python:3.13-slim AS backend

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

# Copy poetry files first for caching
COPY poetry.lock pyproject.toml /app/

# Copy the whole backend code
COPY . /app

# Copy frontend build from stage 1 into Django static files
COPY --from=frontend-build /app/frontend/apps/ui/dist /app/papermerge/core/static/ui

# Install backend dependencies
RUN poetry install -E pg

# Collect static files (frontend + backend assets)
RUN poetry run python manage.py collectstatic --noinput

# Copy entrypoint script and make it executable
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose port 8000 for Django
EXPOSE 8000

# Start server using entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
