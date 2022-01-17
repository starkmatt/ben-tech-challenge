FROM node:17
WORKDIR /usr/src/app
COPY app.js package*.json ./
RUN npm install
EXPOSE 8080
CMD ["node", "app.js"]