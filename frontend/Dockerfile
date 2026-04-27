FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .


FROM node:18-alpine

WORKDIR /app

RUN apk add --no-cache wget

COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY --from=builder /app .

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000

HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
  CMD wget --spider -q http://localhost:3000/health || exit 1

CMD ["node", "app.js"]
