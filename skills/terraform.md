# Terraform Skill

## Purpose

This document defines the Terraform standards used throughout this project.

The objective is to provision AWS infrastructure using Infrastructure as Code (IaC) while keeping the configuration simple, maintainable, reproducible, and cost-efficient.

Terraform should manage infrastructure only.

Application deployment belongs to Kubernetes and GitHub Actions.

---

# General Principles

Always:

- Keep Terraform code modular.
- Keep configuration readable.
- Use variables instead of hardcoded values.
- Keep resources organized.
- Store all infrastructure inside Git.

Avoid unnecessary complexity.

---

# Directory Structure

Terraform files should be stored under:

terraform/

Recommended structure:

terraform/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── terraform.tfvars.example
└── README.md

As the project grows, modules may be introduced.

---

# Infrastructure Scope

Terraform is responsible for creating AWS infrastructure only.

Examples:

- Amazon EKS Cluster
- IAM Roles
- Networking (when required)
- Supporting AWS resources

Terraform should not deploy application code.

---

# State Management

Terraform state must never be committed to Git.

Ignore:

terraform.tfstate

terraform.tfstate.backup

.terraform/

Use a remote backend only if explicitly required.

For this learning project, local state is acceptable.

---

# Variables

Never hardcode values that may change.

Use variables for:

- AWS Region
- Cluster Name
- Project Name
- Environment
- Tags

Provide sensible defaults whenever appropriate.

---

# Outputs

Export important values.

Examples:

- Cluster Name
- Cluster Endpoint
- Region

Outputs should make later deployment easier.

---

# Naming Convention

Use descriptive resource names.

Example:

namegen-eks

namegen-cluster

namegen-role

Avoid generic names.

---

# Tags

Tag every AWS resource.

Recommended tags:

Project

Environment

Owner

ManagedBy = Terraform

Tags improve resource management and cost visibility.

---

# Providers

Keep provider configuration separate.

Example:

providers.tf

Only enable providers required by the project.

---

# Version Management

Pin Terraform versions.

Pin provider versions.

Avoid automatically upgrading major versions.

---

# Resource Design

Prefer:

- Small Terraform files
- Clear resource names
- Reusable configuration

Avoid:

- Copy-paste blocks
- Duplicate resources
- Unused variables

---

# Cost Optimization

Always create the minimum infrastructure required.

Do not provision:

- Additional VPCs unless required
- Multiple EKS clusters
- Unused EC2 instances

Infrastructure should support the project while minimizing AWS cost.

---

# Security

Never store:

AWS Keys

Passwords

Tokens

inside Terraform files.

Use:

- IAM Roles
- Environment Variables
- GitHub Secrets

Sensitive values should be marked as sensitive when appropriate.

---

# Workflow

Typical Terraform workflow:

terraform init

↓

terraform validate

↓

terraform fmt

↓

terraform plan

↓

Review changes

↓

terraform apply

Only apply reviewed changes.

---

# Destroy

When the project is finished:

terraform destroy

should remove all managed infrastructure.

Avoid leaving unnecessary AWS resources running.

---

# Git Rules

Commit:

.tf

files

Do not commit:

.terraform/

terraform.tfstate

terraform.tfstate.backup

crash.log

---

# Project Rules

Terraform provisions infrastructure.

GitHub Actions deploys the application.

Kubernetes manages workloads.

Keep these responsibilities separated.

---

# Definition of Done

Terraform implementation is complete when:

- Infrastructure can be created from code.
- Infrastructure can be destroyed from code.
- No manual AWS configuration is required.
- Code is modular and readable.
- Variables replace hardcoded values.
- Infrastructure is documented.