FROM node:11
WORKDIR /usr/app
COPY package.json ./
RUN npm install --silent
RUN npm install react-scripts@3.4.3 -g --silent
COPY . ./
EXPOSE 8090
CMD ["npm", "start"]
