# ---------- STAGE 1: BUILD ----------
FROM node:18-alpine AS builder

WORKDIR /app

# Install dependencies (production only)
COPY package*.json ./
RUN npm install --omit=dev

# Copy source
COPY . .

# ---------- STAGE 2: PRODUCTION IMAGE ----------
FROM node:18-alpine

WORKDIR /app

# Copy built app from builder stage
COPY --from=builder /app /app

# Create non-root user (REQUIRED)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Expose frontend port
EXPOSE 3000

# Healthcheck (IMPORTANT for compose dependency)
HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
  CMD wget --spider -q http://localhost:3000/health || exit 1

# Start frontend
CMD ["node", "app.js"]
