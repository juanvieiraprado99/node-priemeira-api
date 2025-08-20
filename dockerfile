FROM node:22-alpine AS builder

WORKDIR /app

COPY . ./

RUN npm ci --only=production --ignore-scripts

EXPOSE 3333 

CMD ["node", "src/server.ts"]