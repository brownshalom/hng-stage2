# HNG Stage 2 DevOps

## Prerequisites

- Docker
- Docker Compose
- Git

## Setup

Clone repo

git clone <repo>

cd repo

Copy environment file

cp .env.example .env

Start stack

docker-compose up --build

## Access

Frontend
http://localhost:3000

API
http://localhost:8000

Health check

curl http://localhost:8000/health
