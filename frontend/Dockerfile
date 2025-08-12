# Use node image
FROM node:18

# Set working directory inside container to frontend monorepo root
WORKDIR /app/frontend

# Copy package.json, yarn.lock, and all workspace folders needed
COPY frontend/package.json frontend/yarn.lock ./ 
COPY frontend/apps ./apps
COPY frontend/packages ./packages

# Install dependencies (including all workspaces)
RUN yarn install

# Build the UI workspace (replace 'ui' with your actual workspace name if different)
RUN yarn workspace ui build

# Expose port if needed (only if you serve static files with a server)
EXPOSE 3000

# CMD to serve your built UI - for example using serve or any static server
RUN yarn global add serve
CMD ["serve", "-s", "apps/ui/dist", "-l", "3000"]
