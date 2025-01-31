#!/bin/bash

# Stop and remove the existing Jenkins container if it exists
if [ "$(docker ps -aq -f name=jenkins)" ]; then
    echo "Stopping and removing existing Jenkins container..."
    docker stop jenkins
    docker rm jenkins
fi

# Build the new Jenkins image
echo "Building new Jenkins image..."
docker build -t jenkins-with-docker-compose .

echo "Starting new Jenkins container..."
docker run -d --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins-with-docker-compose

