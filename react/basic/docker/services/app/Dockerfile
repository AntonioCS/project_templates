ARG NODE_IMAGE_APP_VERSION="22.4.0-alpine3.20"

FROM node:${NODE_IMAGE_APP_VERSION} AS base
WORKDIR /app


FROM base as app_react_dev
ENV NODE_ENV development
## Note: User node should have uid 1000
USER node