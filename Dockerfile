FROM node:20-alpine AS base

ENV NODE_ENV=production
ENV PORT=3000

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY ./public ./public
COPY ./.next/standalone ./
COPY ./.next/static ./.next/static

USER nextjs
EXPOSE $PORT

ENTRYPOINT ["node", "server.js"]