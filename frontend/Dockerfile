# Inside frontend/Dockerfile
FROM node:18

WORKDIR /app

COPY package.json yarn.lock ./
COPY apps ./apps
COPY packages ./packages

RUN yarn install

RUN yarn workspace ui build

EXPOSE 3000

RUN yarn global add serve

CMD ["serve", "-s", "apps/ui/dist", "-l", "3000"]
