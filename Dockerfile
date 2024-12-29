FROM node:20-alpine AS base
WORKDIR /app

ENV PORT=3000

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY ./public ./public
COPY ./.next/standalone ./
COPY ./.next/static ./.next/static

USER nextjs
EXPOSE $PORT

ENTRYPOINT ["node", "server.js"]