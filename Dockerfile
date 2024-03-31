FROM node:17-alpine AS base

USER root

FROM base AS deps
RUN apk add --no-cache libc6-compat

WORKDIR /BACKEND
COPY package*.json ./
RUN yarn install

FROM base AS builder
WORKDIR /BACKEND
COPY --from=deps /BACKEND/node_modules ./node_modules
COPY . .

RUN yarn run build


CMD ["yarn", "start"]