FROM node:18-alpine

WORKDIR /app

# Install git (required for some dependencies)
RUN apk add --no-cache git

# Copy package files first for better caching
COPY app/package*.json ./
COPY app/yarn.lock ./

# Install dependencies without running postinstall scripts
RUN yarn install --frozen-lockfile --ignore-scripts

# Copy the rest of the application
COPY app/ ./

# Build the application
RUN yarn build

# Install serve globally
RUN yarn global add serve

EXPOSE 3000
CMD ["serve", "-s", "build"]