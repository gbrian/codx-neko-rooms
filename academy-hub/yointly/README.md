# Dockerfile.vnc

This Dockerfile is used to create a Docker image that runs a VNC server, a Firefox browser, and a NoVNC client in an Ubuntu environment. The Docker image is designed to be used for remote desktop access via a web browser.

## Goals

The Dockerfile.vnc has the following goals:

1. Create an Ubuntu-based Docker image.
2. Install necessary packages such as xvfb, x11vnc, Firefox, novnc, supervisor, websockify, python3, git, curl, wget, and netcat.
3. Set up a VNC server using x11vnc.
4. Run a Firefox browser in the VNC server.
5. Serve the NoVNC client using a Python HTTP server.

## Ports

The Dockerfile.vnc uses the following ports:

- 8080: This port is used by the NoVNC client.
- 5900: This port is used by the VNC server.
- 8081: This port is used by the Python HTTP server to serve the NoVNC client.

## Building and Running the Docker Image

To build the Docker image, navigate to the directory containing the Dockerfile.vnc and run the following command:

```bash
docker build -t yointly:vnc -f Dockerfile.vnc .
```

To run the Docker image, use the following command:

```bash
docker run -d --name test_container yointly:vnc
```

This will start a Docker container named `test_container` running in the background.