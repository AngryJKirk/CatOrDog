FROM node:14
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8032
CMD ["npm", "run", "serve", "--", "--port", "8032"]
