FROM node:18-alpine

WORKDIR /app

# Copy package files first (correct paths)
COPY app/package.json ./
COPY app/yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application
COPY app/ ./

# Build the application
RUN yarn build
RUN yarn global add serve

EXPOSE 3000
CMD ["serve", "-s", "build"]