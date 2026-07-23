# syntax=docker/dockerfile:1

FROM node:24.18.0-bookworm-slim AS build

WORKDIR /app

ENV HUSKY=0

COPY package.json package-lock.json ./

RUN --mount=type=cache,target=/root/.npm \
    npm ci --no-audit --no-fund

COPY . .

RUN npx tsc -p tsconfig.build.json \
    && npx vite build --mode production \
    && npx @capawesome/cli manifests:generate --path dist

FROM nginx:stable-alpine AS runtime

RUN rm -rf /usr/share/nginx/html/*

COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 8080

HEALTHCHECK \
    --interval=30s \
    --timeout=5s \
    --start-period=10s \
    --retries=3 \
    CMD wget --quiet --output-document=- http://127.0.0.1:8080/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]
