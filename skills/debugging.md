# Debugging Skill

## Purpose

This document defines the debugging methodology for this project.

The objective is to troubleshoot issues in a structured, repeatable, and efficient manner.

Never guess the cause of a problem.

Always collect evidence before proposing a solution.

---

# General Principles

Always:

- Understand the problem first.
- Collect evidence.
- Identify the root cause.
- Apply the smallest possible fix.
- Verify the fix.

Avoid making multiple changes simultaneously.

---

# Debugging Process

Every issue should follow this workflow:

Observe

↓

Collect Information

↓

Identify Root Cause

↓

Implement Fix

↓

Verify Solution

↓

Document Findings

Do not skip steps.

---

# Information Collection

Before suggesting any solution, collect relevant information.

Possible sources:

- kubectl get
- kubectl describe
- kubectl logs
- kubectl events
- GitHub Actions logs
- Terraform output
- AWS Console (only when necessary)

Never assume.

---

# Kubernetes Debugging

Start with:

kubectl get pods

↓

kubectl describe pod

↓

kubectl logs

↓

kubectl get events

↓

kubectl rollout status

Common issues include:

- CrashLoopBackOff
- ImagePullBackOff
- Pending
- ErrImagePull
- FailedScheduling

Always identify the exact error before proposing a fix.

---

# Deployment Issues

Verify:

- Deployment exists.
- Image tag is correct.
- Environment variables are set.
- Secrets exist.
- ConfigMaps exist.
- Service selectors match Pod labels.

---

# Service Issues

Verify:

- Service exists.
- Labels match selectors.
- Correct Service type.
- Correct targetPort.
- Endpoints exist.

---

# MongoDB Issues

Verify:

- StatefulSet is running.
- PVC is Bound.
- Service exists.
- MONGODB_URL is correct.
- Authentication settings are correct.

Never assume the application is the problem before verifying MongoDB.

---

# Docker Issues

Verify:

- Docker image builds.
- Image exists in Docker Hub.
- Correct image tag.
- Container starts locally.
- Environment variables are passed correctly.

---

# GitHub Actions

Check:

- Failed workflow step.
- Build logs.
- Docker build logs.
- Docker push logs.
- AWS authentication.
- kubectl deployment logs.

Always investigate the first failure.

Subsequent failures may be side effects.

---

# Terraform

Verify:

terraform validate

terraform plan

terraform apply

Review:

- State
- Outputs
- Variables
- Provider configuration

Never edit Terraform state manually unless absolutely necessary.

---

# AWS

Verify:

- EKS Cluster
- IAM permissions
- Load Balancer
- Region
- Security Groups

Avoid making AWS Console changes that are not reflected in Terraform.

---

# Problem Solving Rules

Prefer:

- One change at a time.
- Reproducible fixes.
- Evidence-based decisions.

Avoid:

- Random changes.
- Restarting everything without investigation.
- Deleting resources before understanding the issue.

---

# Verification

A fix is complete only after:

- The original problem no longer exists.
- No new problems were introduced.
- The deployment succeeds.
- The application functions correctly.

---

# Documentation

When a significant issue is resolved, document:

- Root cause
- Fix
- Verification steps
- Prevention strategy

This helps prevent the same issue in future.

---

# Project Rule

Debugging should always be:

Methodical

Repeatable

Evidence-based

Simple

Do not guess.

Investigate first.