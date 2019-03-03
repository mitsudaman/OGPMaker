FROM node:10-alpine
RUN npm install -g vue-cli
WORKDIR /OGPMaker
ENV HOST 0.0.0.0
EXPOSE 3000