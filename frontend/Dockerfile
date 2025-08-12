# --- Build stage ---
FROM node:20 AS build

WORKDIR /app

# Enable Corepack to support Yarn 4+ per your packageManager config
RUN corepack enable

COPY . .

# Install dependencies
RUN yarn install

# Build only the UI workspace
RUN yarn workspace ui build

# --- Serve stage ---
FROM node:20-alpine

# Install a lightweight static file server
RUN npm install -g serve

WORKDIR /app

# Copy the build output
COPY --from=build /app/apps/ui/dist ./dist

# Railway exposes PORT env var
ENV PORT=8080

# Serve the static files directly
CMD ["sh", "-c", "serve -s ./dist -l $PORT -L"]
