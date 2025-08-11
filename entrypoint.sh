#!/bin/sh
set -e

echo "Running database migrations..."
poetry run task migrate

echo "Starting Papermerge server..."
poetry run task server

poetry run uvicorn docker.__cloud__obsolete.config.asgi:application --host 0.0.0.0 --port ${PORT:-8000}
