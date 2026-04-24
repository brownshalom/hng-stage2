# ---------- BASE IMAGE ----------
FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Create non-root user (REQUIRED)
RUN useradd -m appuser
USER appuser

# Run worker process
CMD ["python", "worker.py"]
