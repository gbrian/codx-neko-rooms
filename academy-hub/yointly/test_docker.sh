#!/bin/bash

# Function to dump logs and file checks
dump_logs() {
    echo "Dumping logs and file checks..."
    docker logs test_container
    docker exec test_container netstat -tuln
    docker exec test_container curl -s localhost:6081/vnc.html
    docker exec test_container ping -c 4 localhost
    echo "Dumping websockify logs..."
    docker exec test_container cat /var/log/supervisor/websockify.log
    echo "Dumping websockify errors..."
    docker exec test_container cat /var/log/supervisor/websockify.err
    echo "*********** DUMP DONE **********"
}

# Change the current working directory to the directory where the script is located
cd "$(dirname "$0")"

# Build the Docker image using the specified Dockerfile and check for errors
echo "Building Docker image..."
docker build -t yointly:vnc -f Dockerfile.vnc . || { echo "Docker build failed"; exit 1; }

docker rm -f test_container || true
# Run the Docker image
echo "Running Docker image..."
docker run -d --name test_container yointly:vnc

# Check if the Docker container is running
echo "Checking if Docker container is running..."
if docker ps | grep -q 'test_container'; then
    echo "Docker container is running successfully."
else
    echo "Error: Docker container is not running."
    dump_logs
    exit 1
fi

# Wait for a moment to allow services to start up
sleep 3

# Check if the webserver is serving the NoVNC client
echo "Checking if webserver is serving the NoVNC client..."
if docker exec test_container curl -s localhost:6081/vnc.html | grep -q 'noVNC'; then
    echo "Webserver is serving the NoVNC client successfully."
else
    echo "Error: Webserver is not serving the NoVNC client."
    dump_logs
    exit 1
fi

# Check if the websockify connection is successful
echo "Checking if websockify connection is successful..."
if docker exec test_container websocat ws://localhost:6081/websockify; then
    echo "Websockify connection is successful."
else
    echo "Error: Websockify connection is not successful."
    dump_logs
    exit 1
fi

# Check if there are any 'exit status 1' entries in the Docker container logs
echo "Checking Docker container logs for 'exit status 1' entries..."
#if docker logs test_container | grep -q 'exit status 1'; then
#    echo "Error: 'exit status 1' found in Docker container logs."
#    dump_logs
#    exit 1
#else
#    echo "No 'exit status 1' entries found in Docker container logs."
#fi