# Snipe-IT on AWS ECS Fargate

A production-inspired DevOps project that deploys the open-source Snipe-IT asset management application to AWS using Docker, Amazon ECS Fargate, Terraform and GitHub Actions.

The project demonstrates modern Infrastructure as Code (IaC), secure cloud networking, container orchestration and CI/CD automation. The entire AWS environment is provisioned with Terraform, whilst GitHub Actions automates infrastructure validation, deployment and destruction using AWS OpenID Connect (OIDC), removing the need for long-lived AWS credentials.

---

# Live Demo

**Application**

https://tm.abdimajidcloud.com

---

# Architecture

> Replace with your Draw.io architecture diagram.

---

# Project Objectives

The goal of this project was to build a production-style AWS environment using modern DevOps practices rather than deploying infrastructure manually.

Key objectives included:

- Containerising an existing application using Docker
- Deploying containers with Amazon ECS Fargate
- Provisioning infrastructure entirely with Terraform
- Building reusable Terraform modules
- Creating secure networking with public and private subnets
- Protecting the application using HTTPS
- Automating deployments using GitHub Actions
- Authenticating GitHub Actions securely using AWS OIDC

---

# Technologies

## Cloud

- Amazon ECS Fargate
- Amazon VPC
- Amazon RDS (MariaDB)
- Amazon Route53
- Amazon ECR
- Application Load Balancer
- AWS Certificate Manager
- Amazon CloudWatch
- AWS IAM
- Amazon S3

## DevOps

- Terraform
- Docker
- GitHub Actions
- OpenID Connect (OIDC)
- Git
- Linux

---

# Architecture Overview

The application follows a secure multi-tier architecture.

User requests first reach Amazon Route53 before being routed to an internet-facing Application Load Balancer.

The load balancer terminates HTTPS using AWS Certificate Manager before forwarding requests to ECS Fargate tasks running inside private subnets.

The application communicates with an Amazon RDS MariaDB database that is also deployed within private subnets.

A NAT Gateway allows the ECS tasks to download updates and communicate with external AWS services without exposing them directly to the internet.

---

# Infrastructure

The infrastructure is provisioned entirely using Terraform modules.

```
Internet
     │
     ▼
 Route53
     │
     ▼
Application Load Balancer
     │
 ┌───┴───────────────┐
 │                   │
 ▼                   ▼
Private Subnet A   Private Subnet B
     │                   │
     └──── ECS Fargate ──┘
             │
             ▼
        Amazon RDS
             │
             ▼
        Private Subnets

Public Subnets
    │
    ├── Internet Gateway
    └── NAT Gateway
```

---

# Security

Security was a major focus throughout the project.

### Network Security

- ECS tasks run inside private subnets
- Amazon RDS is deployed in private subnets
- Only the Application Load Balancer is publicly accessible
- Security Groups restrict communication between AWS services
- NAT Gateway provides secure outbound internet access

### HTTPS

- TLS certificates managed by AWS Certificate Manager
- HTTP automatically redirects to HTTPS
- Modern TLS security policy enabled

### Authentication

GitHub Actions authenticates with AWS using OpenID Connect (OIDC).

This removes the need to store AWS access keys inside GitHub Secrets and follows AWS security best practices.

---

# Terraform Modules

The infrastructure has been split into reusable modules.

```
modules/
├── acm
├── alb
├── ecr
├── ecs
├── rds
├── route53
├── security
└── vpc
```

Each module manages a single AWS service, making the infrastructure easier to maintain and extend.

---

# CI/CD

The project uses four GitHub Actions workflows.

### Build & Push

- Builds the Docker image
- Pushes the image to Amazon ECR

### Terraform Plan

- Terraform formatting
- Validation
- TFLint
- Execution plan

### Terraform Deploy

- Authenticates using AWS OIDC
- Initialises Terraform
- Deploys infrastructure automatically

### Terraform Destroy

- Safely removes all AWS infrastructure
- Used for cost management during development

---

# Repository Structure

```
.
├── app/
│   ├── application
│   └── Dockerfile
│
├── infra/
│   ├── modules/
│   ├── backend.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── main.tf
│
├── .github/
│   └── workflows/
│
└── README.md
```

---

# Local Development

Clone the repository.

```bash
git clone https://github.com/AbdimajidHussein03/snipeit-ecs-deployment.git
```

Navigate into the project.

```bash
cd snipeit-ecs-deployment
```

Build the Docker image.

```bash
docker build -t snipe-it .
```

Run the application.

```bash
docker run -p 8080:80 snipe-it
```

---

# Terraform

Initialise Terraform.

```bash
terraform init
```

Validate the configuration.

```bash
terraform validate
```

Generate a plan.

```bash
terraform plan
```

Deploy the infrastructure.

```bash
terraform apply
```

Destroy the infrastructure.

```bash
terraform destroy
```

---

# Screenshots

Include screenshots of:

- GitHub Actions workflows
- ECS Cluster
- ECS Service
- ECS Tasks
- Amazon ECR
- Application Load Balancer
- Target Group
- Amazon RDS
- Route53
- ACM certificate
- CloudWatch logs
- Running application

---

# Skills Demonstrated

This project demonstrates practical experience with:

- Infrastructure as Code using Terraform
- AWS networking
- Docker containerisation
- Amazon ECS Fargate
- Application Load Balancing
- Amazon RDS
- HTTPS implementation
- DNS management with Route53
- GitHub Actions CI/CD
- OpenID Connect (OIDC)
- IAM security
- Modular Terraform design
- Remote Terraform state
- Cloud architecture
- Linux

---

# Challenges & Key Learning

During development I improved the infrastructure by:

- Refactoring Terraform into reusable modules
- Moving ECS tasks into private subnets
- Introducing a NAT Gateway for secure outbound connectivity
- Separating Route53 into its own Terraform module
- Configuring HTTPS with automatic HTTP redirection
- Implementing GitHub Actions authentication using AWS OIDC
- Managing Terraform remote state securely with Amazon S3

These improvements resulted in a more secure, maintainable and production-inspired deployment.

---

# Future Improvements

- ECS Auto Scaling
- Blue/Green deployments
- AWS Secrets Manager
- CloudWatch dashboards and alarms
- AWS WAF
- CloudFront
- Multi-environment deployments
- Rolling application deployments

---

# Author

**Abdimajid Hussein**

Computer Science Graduate with a strong interest in Cloud Engineering, DevOps and AWS.

GitHub: https://github.com/AbdimajidHussein03

LinkedIn: *(add your LinkedIn profile here)*
