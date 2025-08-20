# syntax = docker/dockerfile:1

# Adjust NODE_VERSION as desired
ARG NODE_VERSION=22
FROM node:${NODE_VERSION}-slim AS base

LABEL fly_launch_runtime="Node.js"

# Node.js app lives here
WORKDIR /app

# Set production environment and disable Husky hooks in CI/containers
ENV NODE_ENV="production" \
    HUSKY=0

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build native node modules (e.g., argon2)
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential node-gyp pkg-config python-is-python3 && \
    rm -rf /var/lib/apt/lists/*

# Install production dependencies only, without running lifecycle scripts
COPY package.json package-lock.json ./
RUN npm ci --only=production --ignore-scripts

# Copy application code
COPY . .

# Final stage for app image
FROM base

# Copy built application (code + node_modules)
COPY --from=build /app /app

# Start the server by default, this can be overwritten at runtime
EXPOSE 3333
CMD [ "node", "--experimental-strip-types", "src/server.ts" ]
