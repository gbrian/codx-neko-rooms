#!/bin/bash

# Change the current working directory to the directory where the script is located
cd "$(dirname "$0")"

# Build the Docker image using the specified Dockerfile
docker build -t yointly:vnc -f Dockerfile.vnc .

docker rm -f test_container || true
# Run the Docker image
docker run -d --name test_container yointly:vnc

# Check if the Docker container is running
if docker ps | grep -q 'test_container'; then
    echo "Docker container is running successfully."
    # Wait for a moment to allow services to start up
    sleep 3
    # Check if the VNC service is running inside the Docker container
    if docker exec test_container ps -ef | grep -q 'x11vnc' && \
        docker exec test_container ps -ef | grep -q 'firefox' && \
        docker exec test_container netstat -tuln | grep -q '5900'; then
        echo "VNC service is running successfully inside the Docker container."
        sleep 3
        if docker exec test_container curl -s localhost:8081 | grep -q 'noVNC'; then
            echo "Webserver is serving the NoVNC client successfully."
            # Check if there are any 'exit status 1' entries in the Docker container logs
            if docker logs test_container | grep -q 'exit status 1'; then
                echo "Error: 'exit status 1' found in Docker container logs."
                # Output the Docker container logs for troubleshooting
                docker logs test_container
                # Output the logs of firefox and vnc for further analysis
                echo "Output of firefox logs:"
                docker exec test_container cat /var/log/supervisor/firefox.log
                echo "Output of vnc logs:"
                docker exec test_container cat /var/log/supervisor/vnc.log
                echo "Output of netstat command:"
                docker exec test_container netstat -tuln
                exit 1
            fi
        else
            echo "Error: Webserver is not serving the NoVNC client."
            # Output the Docker container logs for troubleshooting
            docker logs test_container
            # Output the result of curl command for troubleshooting
            echo "Output of curl command:"
            docker exec test_container curl -s localhost:8081
            echo "Output of ping command:"
            docker exec test_container ping -c 4 localhost
            exit 1
        fi
    else
        echo "Error: VNC service is not running inside the Docker container."
        # Output the Docker container logs for troubleshooting
        docker logs test_container
        # Output the firefox logs for troubleshooting
        echo "Output of firefox logs:"
        docker exec test_container cat /var/log/supervisor/firefox.log
        exit 1
    fi
else
    echo "Error: Docker container is not running."
    exit 1
fi