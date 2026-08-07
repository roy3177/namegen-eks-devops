# Kubernetes Skill

## Purpose

This document defines the Kubernetes standards and conventions used throughout this project.

The goal is to keep every Kubernetes resource consistent, simple, and production-oriented.

These guidelines apply to every manifest created for this repository.

---

# General Principles

Always:

- Keep manifests simple and readable.
- Create one Kubernetes resource per YAML file.
- Use descriptive resource names.
- Keep labels and selectors consistent.
- Prefer declarative configuration.
- Avoid unnecessary Kubernetes features.

Do not introduce additional components unless they are required by the project.

---

# Directory Structure

Store all Kubernetes manifests under:

kubernetes/

Example:

kubernetes/
├── namespace.yaml
├── deployment.yaml
├── service.yaml
├── mongodb-statefulset.yaml
├── mongodb-service.yaml
├── mongodb-pvc.yaml
├── configmap.yaml
└── secret.yaml

---

# Namespace

Deploy all project resources inside a dedicated namespace.

Do not deploy resources into the default namespace.

---

# Deployments

Use Deployment only for stateless workloads.

Application:

- Node.js
- API
- Frontend

Deployment guidelines:

- At least one replica.
- Use labels.
- Use selectors.
- Define resource requests and limits whenever appropriate.

---

# Stateful Applications

MongoDB must always be deployed using:

- StatefulSet
- PersistentVolumeClaim

Never deploy MongoDB as a Deployment.

Persistent storage is mandatory.

---

# Services

Use:

ClusterIP

for internal communication.

Use:

LoadBalancer

only when external access is required.

Avoid exposing internal services publicly.

---

# Labels

Use consistent labels across all resources.

Recommended labels:

app: namegen

component: application

environment: production

Labels and selectors must always match.

---

# Configuration

Store configuration separately from application code.

Use:

- ConfigMap
- Secret

Never hardcode credentials inside YAML files.

---

# Container Images

Always use versioned image tags.

Avoid:

latest

unless explicitly required.

---

# Resource Naming

Use descriptive names.

Examples:

namegen-app

namegen-service

mongodb

mongodb-service

mongodb-pvc

Avoid generic names like:

app

service

database

---

# Validation

Before applying any manifest:

Validate YAML.

Review resource names.

Verify labels and selectors.

Confirm referenced resources exist.

---

# Deployment Verification

After deployment always verify:

Pods

Deployments

StatefulSets

Services

PersistentVolumeClaims

Rollout Status

The deployment should not be considered complete until all resources are healthy.

---

# Best Practices

Prefer:

- Small manifests
- Readable YAML
- Explicit configuration
- Separate resources
- Production-oriented configuration

Avoid:

- Duplicate manifests
- Large multi-resource YAML files
- Unused Kubernetes objects
- Manual modifications inside the cluster

All infrastructure changes should be stored in Git.