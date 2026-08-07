# Docker Skill

## Purpose

This document defines the Docker standards for this project.

The objective is to produce small, reproducible, secure, and production-ready Docker images.

Docker images should remain simple, efficient, and easy to maintain.

---

# General Principles

Always:

- Build production-ready images.
- Keep images as small as possible.
- Use official base images.
- Pin image versions when practical.
- Keep Dockerfiles readable.

Avoid unnecessary layers and unnecessary packages.

---

# Dockerfile Location

The project should contain a single Dockerfile located at:

/
├── Dockerfile

Unless multiple services are introduced in the future.

---

# Base Image

Prefer lightweight official images.

For Node.js applications:

- node:lts-alpine

or another stable LTS version if required.

Avoid unnecessarily large base images.

---

# Build Strategy

Prefer multi-stage builds when they reduce image size.

Separate:

- Build stage
- Runtime stage

when appropriate.

If the application is simple and multi-stage provides little benefit, keep the Dockerfile simple.

---

# Working Directory

Always define a working directory.

Example:

/app

Keep the container filesystem organized.

---

# Dependency Installation

Copy dependency files before copying the full application.

Example order:

package.json

↓

package-lock.json

↓

npm install

↓

Copy application source

This improves Docker layer caching.

---

# .dockerignore

Always include a .dockerignore file.

Typical exclusions:

node_modules

.git

.gitignore

README.md

screenshots

terraform

skills

docs

Temporary files

Only include files required to build the application.

---

# Environment Variables

Do not hardcode configuration values.

Use environment variables for:

- Database connection
- Ports
- Environment
- Secrets

Example:

MONGODB_URL

PORT

NODE_ENV

---

# Secrets

Never store:

- Passwords
- API Keys
- AWS Credentials
- Tokens

inside:

- Dockerfile
- Image
- Source code

Secrets should be provided at runtime.

---

# Exposed Ports

Expose only the required application port.

Do not expose unnecessary ports.

---

# Image Tags

Always use immutable tags.

Preferred:

application:<git-sha>

Avoid relying only on:

latest

---

# Container User

Avoid running containers as root whenever possible.

Use a dedicated application user when supported.

---

# Logging

Applications should log to:

stdout

stderr

Do not write application logs to local container files.

Kubernetes should collect container logs.

---

# Health

If supported by the application, provide a health check endpoint.

Example:

/health

Health verification should be handled by Kubernetes.

---

# Build Verification

Every Docker image should:

- Build successfully.
- Start successfully.
- Connect to MongoDB.
- Run without manual configuration.
- Support environment variables.

---

# Best Practices

Prefer:

- Small images
- Readable Dockerfiles
- Stable image versions
- Layer caching
- Production configuration

Avoid:

- Large images
- Development-only tools
- Hardcoded values
- Running as root
- Installing unnecessary packages

---

# Cost Considerations

Docker images should remain lightweight.

Smaller images reduce:

- Build time
- Push time
- Pull time
- Deployment time

This improves CI/CD performance.

---

# Project Rules

For this project:

- One Dockerfile.
- One application image.
- MongoDB uses the official image.
- Do not build MongoDB manually.
- Keep the Docker configuration as simple as possible.

---

# Definition of Done

The Docker implementation is complete when:

- The image builds successfully.
- The container starts successfully.
- Environment variables are supported.
- The application connects to MongoDB.
- The image is ready for deployment on Amazon EKS.