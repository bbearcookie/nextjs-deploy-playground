FROM node:20-alpine AS base
WORKDIR /app

ARG DATADOG_API_KEY
ARG DATADOG_SERVICE
ARG DATADOG_VERSION
ENV PORT=3000

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY ./public ./public
COPY ./.next/standalone ./
COPY ./.next/static ./.next/static

RUN pwd
RUN ls -al .

# datadog-ci로 소스맵 업로드
RUN npx datadog-ci sourcemaps upload /src \
    --service=${DATADOG_SERVICE} \
    --release-version=${DATADOG_VERSION} \
    --minified-path-prefix=${DATADOG_PATH_PREFIX}

USER nextjs
EXPOSE $PORT

ENTRYPOINT ["node", "server.js"]