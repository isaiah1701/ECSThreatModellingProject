FROM node:18-alpine

WORKDIR /app

# Install git (required for some dependencies)
RUN apk add --no-cache git

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . ./

# Expose port
EXPOSE 3000

# Start the application directly with ts-node
CMD ["npx", "ts-node", "src/app.ts"]