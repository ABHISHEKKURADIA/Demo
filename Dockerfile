FROM node:18-alpine
WORKDIR /app
COPY . .
EXPOSE 9000
RUN npm install
CMD ["node", "app.js"]