FROM node:22-alpine

USER node
WORKDIR /app

COPY --chown=node:node . .

RUN npm install
RUN npm ci --only=production
RUN npm audit fix

EXPOSE 3000

CMD ["node", "server.js"]