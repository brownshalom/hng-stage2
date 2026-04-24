# ---------- BASE IMAGE ----------
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies (needed for curl healthcheck)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install Python dependencies first (better caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app source
COPY . .

# Create non-root user (REQUIRED)
RUN useradd -m appuser
USER appuser

# Expose API port
EXPOSE 8000

# Healthcheck (REQUIRED by assignment)
HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
  CMD curl --fail http://localhost:8000/health || exit 1

# Start API
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
