#!/bin/bash

set -e

echo "Starting integration tests..."

docker-compose up -d --build

sleep 10

# API health check
curl --fail http://localhost:3000/health

# API endpoint check
curl --fail http://localhost:8000/health

echo "All services are healthy"

docker-compose down

exit 0
