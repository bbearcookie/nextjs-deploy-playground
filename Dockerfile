FROM node:20-alpine AS base
WORKDIR /app

ARG VERSION
ARG DATADOG_API_KEY # datadog-ci를 위해서 사용되는 API 키
ARG DATADOG_SITE # 리전을 지정해야 할 때 사용
ARG DATADOG_SERVICE
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
RUN npx datadog-ci sourcemaps upload ./.next/static/chunks \
    --service=${DATADOG_SERVICE} \
    --release-version=${VERSION} \
    --minified-path-prefix=${DATADOG_PREFIX}

# 빌드된 결과물에서 소스맵 제거
RUN find ./ -type f -name "*.map" -delete

USER nextjs
EXPOSE $PORT

ENTRYPOINT ["node", "server.js"]
