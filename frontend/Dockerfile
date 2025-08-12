FROM node:18

WORKDIR /app

# Enable Corepack to support Yarn 4+ per your packageManager config
RUN corepack enable

# Copy package files to install deps first (cache layer)
COPY package.json yarn.lock ./

# Copy tsconfig files needed for build (important for TS extends)
COPY tsconfig.json tsconfig.base.json ./

# Copy your source code folders
COPY apps ./apps
COPY packages ./packages

# Install dependencies (will use Yarn 4 automatically)
RUN yarn install

# Build your UI workspace
RUN yarn workspace ui build

# Expose the port to serve your frontend
EXPOSE 3000

# Install simple static file server globally
RUN yarn global add serve

# Command to serve your built app
CMD ["serve", "-s", "apps/ui/dist", "-l", "3000"]
