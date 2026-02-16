#!/bin/bash
apt update -y
apt install docker.io -y
systemctl start docker
systemctl enable docker

docker pull ${image}

docker run -d \
  --name strapi \
  -p 1337:1337 \
  ${image}
