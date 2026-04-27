# ---------- BUILD STAGE ----------
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .


# ---------- PRODUCTION STAGE ----------
FROM node:18-alpine

WORKDIR /app

# install wget for healthcheck
RUN apk add --no-cache wget

# create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# copy app from builder
COPY --from=builder /app /app

USER appuser

EXPOSE 3000

# IMPORTANT FIX: add start-period to avoid early healthcheck failure
HEALTHCHECK --interval=10s --timeout=5s --start-period=20s --retries=5 \
  CMD wget --spider -q http://localhost:3000/health || exit 1

CMD ["node", "app.js"]
