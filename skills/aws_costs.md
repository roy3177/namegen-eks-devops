# AWS Cost Optimization Skill
This skill defines the cost optimization rules for all AWS-related decisions in this project.
## Purpose

This project must be completed with the lowest possible AWS cost while still meeting all project requirements.

Cost optimization is a primary design constraint.

---

# General Principles

Always:

- Prefer AWS Free Tier eligible services whenever possible.
- Use the minimum number of AWS resources required.
- Keep the architecture simple.
- Avoid unnecessary managed services.
- Reuse existing AWS resources when appropriate.
- Remove temporary resources after testing.

Never create infrastructure that is not required by the project.

---

# Before Creating Any AWS Resource

Always ask:

1. Is this resource required?
2. Is there a cheaper alternative?
3. Can an existing resource be reused?
4. Will this resource continue generating charges after the project?

If the answer is uncertain, explain the potential cost before proceeding.

---

# Resource Guidelines

## EKS

- Create only one cluster.
- Do not create multiple clusters.
- Destroy the cluster when the project is finished.

---

## EC2

- Prefer the smallest supported instance types.
- Never recommend oversized instances.

---

## Load Balancer

- Create only when required by the project.
- Explain that Load Balancers may incur charges.
- Delete the Load Balancer after project completion.

---

## Storage

- Use only the storage required.
- Delete unused Persistent Volumes.
- Delete unused EBS volumes after testing.

---

## Container Registry

Prefer Docker Hub unless Amazon ECR is specifically required.

Avoid creating unnecessary AWS services.

---

## Monitoring

Use CloudWatch only when necessary.

Avoid enabling paid monitoring features.

---

# Secrets

Never hardcode AWS credentials.

Always use:

- GitHub Secrets
- IAM Roles
- Kubernetes Secrets

---

# Cleanup Checklist

After completing the project verify that:

- EKS Cluster has been deleted (if no longer needed).
- Load Balancer has been deleted.
- Persistent Volumes have been removed.
- Unused EBS volumes have been removed.
- Unused Docker images have been deleted.
- No unnecessary AWS resources remain running.

---

# Decision Making

When multiple solutions exist:

1. Recommend the lowest-cost solution.
2. Explain the cost trade-offs.
3. Mention if the recommendation differs from enterprise best practices.

For this project, minimizing AWS cost is more important than demonstrating advanced AWS services.