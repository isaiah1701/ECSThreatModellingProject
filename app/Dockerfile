FROM node:18-alpine

WORKDIR /app

RUN apk add --no-cache git

# Copy package files
COPY package*.json ./

# Install deps
RUN npm install

# Copy source
COPY . .

# Build the TypeScript app
RUN npm run build  # make sure this script exists in package.json

# Expose the app port
EXPOSE 3000

# Run the built JS file
CMD ["node", "dist/app.js"]  # adjust if your output is in a different file
