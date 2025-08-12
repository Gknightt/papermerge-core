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

# Copy your start.sh script into the container
COPY start.sh .

# Make the script executable
RUN chmod +x start.sh

# Use the script as the container start command
CMD ["./start.sh"]


