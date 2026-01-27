# Use official Node.js 20 image (slim for smaller size)
FROM node:20-bullseye-slim

WORKDIR /app

# Copy package.json only
COPY package.json ./

# Remove package-lock if exists to prevent integrity mismatch
RUN rm -f package-lock.json

# Clean npm cache, set registry, and install dependencies
RUN npm cache verify \
    && npm config set registry https://registry.npmjs.org/ \
    && npm install --production --legacy-peer-deps

# Copy the rest of the app
COPY . .

# Expose port
EXPOSE 3000

# Run the app
CMD ["node", "index.js"]
