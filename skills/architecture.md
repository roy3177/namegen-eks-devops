# Project Architecture Skill

## Purpose

This document defines the architecture of the project.

Its purpose is to ensure that every implementation follows the same architecture and that no unnecessary components are introduced.

This document represents the source of truth for the system design.

---

# Project Overview

The project deploys the Random Name Generator application on Amazon EKS using modern DevOps practices.

The system consists of:

- Node.js Application
- MongoDB Database
- Kubernetes
- Amazon EKS
- Docker
- GitHub Actions

---

# High-Level Architecture

                    Developer
                        │
                        ▼
                    GitHub Repository
                        │
                        ▼
                 GitHub Actions Pipeline
                        │
                        ▼
                  Build Docker Image
                        │
                        ▼
             Push Image (Docker Hub)
                        │
                        ▼
                 Amazon EKS Cluster
                        │
          ┌─────────────┴─────────────┐
          │                           │
          ▼                           ▼
       Node.js Deployment          MongoDB StatefulSet
          │                           │
          └─────────────┬─────────────┘
                        ▼
              Persistent Volume (EBS)

---

# Request Flow

A typical request follows this path:

User

↓

AWS Network Load Balancer

↓

Kubernetes Service

↓

Node.js Application

↓

MongoDB Service

↓

MongoDB StatefulSet

↓

Persistent Volume

---

# Component Responsibilities

## GitHub

Stores the project source code.

---

## GitHub Actions

Responsible for:

- Building the application
- Building the Docker image
- Publishing the Docker image
- Deploying to Amazon EKS

---

## Docker

Packages the application into a portable container.

---

## Amazon EKS

Runs the Kubernetes cluster.

Responsible for hosting all application workloads.

---

## Kubernetes

Responsible for:

- Scheduling Pods
- Managing Deployments
- Managing StatefulSets
- Service Discovery
- Scaling
- Self-healing

---

## Node.js Application

Provides:

- Web UI
- REST API
- Communication with MongoDB

No application business logic should be moved into Kubernetes.

---

## MongoDB

Stores application data.

Requirements:

- StatefulSet
- Persistent Storage

---

# Design Principles

Always prefer:

- Simple architecture
- Minimum AWS resources
- Production-oriented deployment
- Clear separation of responsibilities
- Infrastructure as Code

Avoid:

- Unnecessary AWS services
- Duplicate components
- Over-engineered solutions
- Manual infrastructure configuration

---

# Scope

This project focuses on:

- Docker
- Kubernetes
- Amazon EKS
- Terraform (or eksctl)
- GitHub Actions
- MongoDB

The project is not intended to demonstrate:

- Service Mesh
- Helm
- ArgoCD
- Prometheus
- Grafana
- Multi-cluster deployments
- High Availability architectures

These technologies should only be introduced if explicitly required.

---

# Architecture Rules

Every new component introduced into the project should:

- Have a clear purpose.
- Fit the existing architecture.
- Be justified before implementation.
- Be evaluated for AWS cost impact.
- Keep the overall architecture simple and maintainable.