FROM node:16
WORKDIR /usr/src/app
COPY app.js package*.json ./
RUN npm install
EXPOSE 80
CMD ["node", "app.js"]