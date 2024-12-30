FROM node:20-alpine AS base
WORKDIR /app

ARG DATADOG_API_KEY
ARG DATADOG_SITE
ARG DATADOG_SERVICE
ARG DATADOG_VERSION
ARG DATADOG_PREFIX
ENV PORT=3000

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY ./public ./public
COPY ./.next/standalone ./
COPY ./.next/static ./.next/static

RUN pwd
RUN ls -al .

# datadog-ci로 소스맵 업로드
RUN npm install -g @datadog/datadog-ci
RUN npx datadog-ci sourcemaps upload ./ \
    --service=${DATADOG_SERVICE} \
    --release-version=${DATADOG_VERSION} \
    --minified-path-prefix=${DATADOG_PREFIX}

USER nextjs
EXPOSE $PORT

ENTRYPOINT ["node", "server.js"]

# FROM node:20-alpine AS base
# WORKDIR /app

# ARG DATADOG_API_KEY
# ARG DATADOG_SITE
# ARG DATADOG_SERVICE
# ARG DATADOG_VERSION
# ARG DATADOG_PREFIX
# ENV PORT=3000

# RUN addgroup --system --gid 1001 nodejs
# RUN adduser --system --uid 1001 nextjs

# COPY ./.next/standalone ./
# COPY ./.next/static ./.next/static

# RUN pwd
# RUN ls -al .

# # datadog-ci로 소스맵 업로드
# RUN npm install -g @datadog/datadog-ci
# RUN npx datadog-ci sourcemaps upload ./ \
#     --service=${DATADOG_SERVICE} \
#     --release-version=${DATADOG_VERSION} \
#     --minified-path-prefix=${DATADOG_PREFIX}

# USER nextjs
# EXPOSE $PORT

# ENTRYPOINT ["node", "server.js"]