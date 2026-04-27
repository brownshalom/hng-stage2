#!/bin/bash

set -e

docker-compose up -d --build

sleep 15

JOB_ID=$(curl -s -X POST http://localhost:3000/submit | jq -r '.job_id')

echo "Job ID: $JOB_ID"

for i in {1..30}; do
  STATUS=$(curl -s http://localhost:3000/status/$JOB_ID | jq -r '.status')

  if [ "$STATUS" == "completed" ]; then
    echo "Job completed"
    docker-compose down
    exit 0
  fi

  sleep 2
done

echo "Timeout waiting for job completion"

docker-compose down
exit 1
