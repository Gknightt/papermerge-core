FROM node:20-alpine

RUN npm install -g serve

WORKDIR /app

COPY --from=build /app/apps/ui/dist ./dist

# Railway exposes PORT env var
ENV PORT=8080

# Use shell form CMD to allow env var expansion
CMD serve -s dist -l 0.0.0.0:$PORT
