FROM node:18-alpine

WORKDIR /app
COPY ./app .

RUN yarn install
RUN yarn build
RUN yarn global add serve

EXPOSE 3000
CMD ["serve", "-s", "build"]