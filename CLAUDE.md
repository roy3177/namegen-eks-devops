# CLAUDE.md

# EKS with CI/CD Pipeline - Final Project

## Project Overview

This repository contains the final DevOps project for deploying the Random Name Generator application on Amazon EKS.

The objective is to demonstrate modern DevOps practices including Infrastructure as Code, Kubernetes, Docker, GitHub Actions, and AWS-native services.

This is a DevOps project, not an application development project.

---

# Project Goals

The project must:

- Deploy the application on Amazon EKS.
- Deploy MongoDB as a StatefulSet.
- Use Persistent Volumes for database persistence.
- Build and deploy the application using GitHub Actions.
- Expose the application using an AWS Network Load Balancer.
- Keep the infrastructure simple, production-oriented, and maintainable.

---

# Working Principles

When assisting with this repository:

- Explain the reasoning before making implementation changes.
- Prefer small, incremental steps over large changes.
- Do not introduce unnecessary complexity.
- Follow Kubernetes and AWS best practices.
- Keep all configurations clean and easy to understand.
- Ask before making architectural decisions that significantly change the project.

---

# Cost Optimization (Very Important)

This project should be built with **minimum AWS cost**.

Always prefer:

- AWS Free Tier eligible services whenever possible.
- The smallest supported instance sizes.
- The minimum number of AWS resources.
- Automatic cleanup of temporary resources.
- Avoid creating duplicate infrastructure.
- Reuse existing infrastructure whenever appropriate.

Avoid suggesting services that introduce unnecessary cost.

Before creating any AWS resource, consider:

- Is it required for the project?
- Is there a cheaper alternative?
- Can an existing resource be reused?

Cost optimization is a primary requirement of this project.

---

# Repository Structure

The repository should remain organized.

Expected structure:

/
├── app/
├── Dockerfile
├── README.md
├── terraform/
├── kubernetes/
├── skills/
├── diagrams/
├── screenshots/
└── .github/
    └── workflows/

---

# Infrastructure

Infrastructure should be managed using Infrastructure as Code.

Preferred approach:

- Terraform

Alternative:

- eksctl

Infrastructure should remain modular and easy to understand.

---

# Kubernetes

The project will deploy:

- Application Deployment
- MongoDB StatefulSet
- PersistentVolumeClaim
- Services
- LoadBalancer Service
- Secrets or ConfigMaps when appropriate

MongoDB must never be deployed as a Deployment.

---

# CI/CD

GitHub Actions should automatically:

1. Build the application
2. Build the Docker image
3. Push the image
4. Deploy to Kubernetes
5. Verify the deployment

Deployment should require minimal manual work.

---

# Documentation

Every major implementation should be documented.

The repository should eventually include:

- README
- Architecture Diagram
- CI/CD Diagram
- Deployment Instructions
- Screenshots

---

# Development Style

Prefer:

- Simple solutions
- Readable YAML
- Readable Terraform
- Clear folder structure
- Reusable configurations

Avoid:

- Over engineering
- Unnecessary dependencies
- Large configuration files
- Unexplained changes

---

# Collaboration Rules

Before implementing:

- Explain the objective.
- Explain why the approach was chosen.
- Mention alternative approaches when relevant.

After implementation:

- Explain what changed.
- Explain how to test it.
- Explain any AWS cost implications.

---
# Project Scope

This project is intended for learning and demonstration purposes.

The Kubernetes configuration should remain as simple as possible while following production best practices.

Do not introduce advanced Kubernetes technologies such as:

- Helm
- ArgoCD
- Istio
- Service Mesh
- Operators
- Horizontal Pod Autoscaler
- Network Policies

unless they are explicitly required by the project.

# Skills

Project-specific knowledge should be stored inside the `/skills` directory.

Keep CLAUDE.md focused on project rules only.