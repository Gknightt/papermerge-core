FROM node:18

WORKDIR /app/frontend

# Copy package.json and yarn.lock from frontend folder
COPY frontend/package.json frontend/yarn.lock ./

# Copy the apps and packages folders
COPY frontend/apps ./apps
COPY frontend/packages ./packages

RUN yarn install

RUN yarn workspace ui build

EXPOSE 3000

RUN yarn global add serve

CMD ["serve", "-s", "apps/ui/dist", "-l", "3000"]
