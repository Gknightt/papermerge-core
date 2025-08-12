#!/bin/sh
echo "PORT=$PORT"
serve -s dist -l 0.0.0.0:${PORT:-3000}
