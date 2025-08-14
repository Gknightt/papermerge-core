FROM node:20.19 AS frontend_build

# Install build deps for native packages
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

WORKDIR /build_frontend_app

# Copy only package.json and yarn.lock first for caching
COPY frontend/package.json frontend/yarn.lock ./

# Enable correct Yarn version
RUN corepack enable && corepack prepare yarn@stable --activate

# Install dependencies
RUN yarn install --mode=update-lockfile --network-timeout 100000

# Copy the rest of the source
COPY frontend/ .

# Build workspaces
RUN yarn workspace hooks build
RUN yarn workspace ui build
