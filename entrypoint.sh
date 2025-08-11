#!/bin/sh
set -e

echo "Running database migrations..."
poetry run task migrate

echo "Starting Papermerge server..."

poetry run uvicorn papermerge.app:app --host 0.0.0.0 --port ${PORT:-8000}

