FROM node:18-alpine
WORKDIR /app
COPY . .
EXPOSE 3030
RUN npm install
CMD ["npm", "app.js"]