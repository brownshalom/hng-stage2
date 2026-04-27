# ---------- BUILD STAGE ----------
FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

COPY . .


# ---------- FINAL STAGE ----------
FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# create non-root user
RUN useradd -m appuser

# copy installed packages (IMPORTANT FIX)
COPY --from=builder /install /usr/local

# copy app
COPY --from=builder /app /app

# fix permissions
RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 8000

HEALTHCHECK --interval=10s --timeout=5s --start-period=20s --retries=5 \
  CMD curl --fail http://localhost:8000/health || exit 1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
