#!/bin/sh
set -e

echo "Applying database migrations..."
yarn prisma migrate deploy

echo "Starting application..."
node dist/src/main.js