FROM node:20.19 AS frontend_build

# Install build deps for native packages
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

WORKDIR /build_frontend_app

# Copy the entire frontend directory
COPY frontend/ .

# Enable correct Yarn version
RUN corepack enable && corepack prepare yarn@stable --activate

# Install dependencies
RUN yarn install --mode=update-lockfile --network-timeout 100000

# Build workspaces
RUN yarn workspace hooks build
RUN yarn workspace ui build
