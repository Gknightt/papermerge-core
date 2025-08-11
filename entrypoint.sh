#!/bin/sh
set -e

echo "Running database migrations..."
poetry run task migrate

echo "Starting Papermerge server..."
poetry run task server
