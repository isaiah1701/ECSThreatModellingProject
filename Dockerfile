FROM node:18-alpine

WORKDIR /app

# Install git (required for some dependencies)
RUN apk add --no-cache git

# Copy package files first for better caching
COPY amazon-threat-composer-app/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY amazon-threat-composer-app/ ./

# Build the TypeScript application
RUN npm run build

# Expose port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]