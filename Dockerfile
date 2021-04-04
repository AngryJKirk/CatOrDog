FROM node:14
RUN npm install -g http-server
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 8032
CMD [ "http-server", "dist", "-p", "8032"]
