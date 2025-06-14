FROM node:18-alpine

WORKDIR /app

# Copy everything from app directory
COPY ./app/ ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Build the application
RUN yarn build
RUN yarn global add serve

EXPOSE 3000
CMD ["serve", "-s", "build"]