# W2D3 Docker Serving Lab

AIDC bootcamp: the LLM serving stack each team builds, weeks 2 to 6.

## Overview
This lab focuses on containerizing and serving applications using Docker, comparing naive approaches with optimized builds for production environments.

## What is Inside
* `Dockerfile.naive`: Standard unoptimized Dockerfile for baseline testing.
* `Dockerfile`: Optimized/slim Dockerfile for production deployment.
* `app/`: Directory containing the application source code and dependencies.
* `.dockerignore`: Files and directories to exclude from the Docker build context.

## Getting Started
Build the Docker image:
docker build -t llm-serving-app .

Run the container:
docker run <img width="2534" height="1350" alt="Screenshot 2026-08-26 102651" src="https://github.com/user-attachments/assets/a34894b6-5d63-45bc-971c-a3a9f65463b1" />

-p 8000:8000 llm-serving-app
