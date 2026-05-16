# Stage 1: Base image for building dependencies
FROM node:18-bullseye-slim AS build

# Set working directory
WORKDIR /app

# Native build deps for packages like sharp. Debian/glibc avoids the musl
# fallback path that pulls Node headers from unofficial-builds.
RUN apt-get update \
  && apt-get install -y --no-install-recommends python3 build-essential pkg-config libvips-dev \
  && rm -rf /var/lib/apt/lists/*

# Copy package files and install dependencies
COPY package*.json ./
COPY vendor ./vendor

# Install only production dependencies first to enable better caching
RUN npm install --omit=dev

# Copy the rest of the code
COPY . .

# Build the admin panel at image build time so Cloud Run startup stays light.
RUN npm run build

# Stage 2: Final slim image
FROM node:18-bullseye-slim

# Set working directory
WORKDIR /app

# Copy just the built app and dependencies from build stage
COPY --from=build /app ./

# Add production-only environment variables
ENV NODE_ENV=production

# Expose Strapi port
EXPOSE 8080

# Start Strapi in production mode
CMD ["npm", "run", "start"]
