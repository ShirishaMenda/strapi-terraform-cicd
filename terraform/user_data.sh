#!/bin/bash
set -e

# Update system
apt update -y

# Install Docker
apt install -y docker.io

# Enable & start Docker
systemctl start docker
systemctl enable docker

# Allow ubuntu user to run docker
usermod -aG docker ubuntu

# Wait for Docker to be ready
sleep 10

# Pull Strapi image
docker pull ${image}

# Run Strapi in production mode
docker run -d \
  --name strapi \
  -p 1337:1337 \
  ${image}
