#!/bin/sh
set -e

echo "Running database migrations..."
poetry run task migrate

echo "Starting Papermerge server..."
poetry run task server

poetry run task server --host 0.0.0.0 --port 8000
