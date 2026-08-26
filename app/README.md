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
```bash
docker build -t llm-serving-app .

Bash
docker run -p 8000:8000 llm-serving-app