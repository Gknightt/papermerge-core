# Use node image
FROM node:18

# Set working directory inside container to frontend monorepo root
WORKDIR /app/frontend

# Copy package.json and yarn.lock from repo root/frontend
COPY package.json yarn.lock ./

# Copy apps and packages folders from repo root/frontend
COPY apps ./apps
COPY packages ./packages

# Install dependencies (including all workspaces)
RUN yarn install

# Build the UI workspace (replace 'ui' with your actual workspace name if different)
RUN yarn workspace ui build

# Expose port if needed (only if you serve static files with a server)
EXPOSE 3000

# Install a simple static server globally
RUN yarn global add serve

# CMD to serve built UI
CMD ["serve", "-s", "apps/ui/dist", "-l", "3000"]
