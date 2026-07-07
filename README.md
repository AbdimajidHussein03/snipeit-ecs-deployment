# Snipe-IT on AWS ECS Fargate

A production-inspired DevOps project demonstrating how to containerise, deploy and manage Snipe-IT on AWS using Docker, Amazon ECS Fargate, Terraform and GitHub Actions.

The project provisions a secure AWS infrastructure using Infrastructure as Code (Terraform), deploys a custom Docker image to Amazon Elastic Container Registry (ECR), and runs the application on ECS Fargate behind an Application Load Balancer with HTTPS enabled using AWS Certificate Manager.

Infrastructure deployments are fully automated through GitHub Actions using OpenID Connect (OIDC), eliminating the need for long-lived AWS credentials.

---

# Live Application

**URL**

https://tm.abdimajidcloud.com

---

# Architecture

> **Insert your architecture diagram here**

```text
images/architecture.png
```

---

# Project Overview

This project demonstrates how to deploy a production-style containerised application on AWS using fully managed services.

The application is built into a Docker image, pushed to Amazon Elastic Container Registry (ECR), and deployed onto Amazon ECS Fargate.

Traffic enters through Amazon Route53 before reaching an Application Load Balancer which terminates HTTPS using AWS Certificate Manager.

The load balancer securely routes requests to ECS tasks running inside private subnets. The application communicates with an Amazon RDS MariaDB database that is also hosted inside private subnets.

Terraform provisions the complete infrastructure while GitHub Actions automates validation, planning, deployment and destruction using AWS IAM Roles for GitHub with OpenID Connect.

---

# Features

- Docker containerised application
- Infrastructure as Code using Terraform
- Modular Terraform architecture
- Amazon ECS Fargate
- Amazon Elastic Container Registry (ECR)
- Application Load Balancer
- HTTPS using AWS Certificate Manager
- HTTP automatically redirects to HTTPS
- Route53 custom domain
- Public and private subnet architecture
- NAT Gateway for secure outbound internet access
- Amazon RDS MariaDB database
- CloudWatch logging
- Remote Terraform state stored in Amazon S3
- Terraform state locking
- GitHub Actions CI/CD
- AWS OpenID Connect (OIDC) authentication
- Least privilege IAM permissions

---

# AWS Services Used

| Service | Purpose |
|----------|----------|
| Amazon ECS Fargate | Runs the application containers |
| Amazon ECR | Stores Docker images |
| Amazon RDS | MariaDB database |
| Application Load Balancer | Distributes incoming traffic |
| Amazon Route53 | DNS management |
| AWS Certificate Manager | HTTPS certificates |
| Amazon VPC | Network isolation |
| Internet Gateway | Public internet access |
| NAT Gateway | Outbound internet access for private resources |
| Security Groups | Network firewall rules |
| AWS IAM | Authentication and permissions |
| Amazon CloudWatch | Logging |
| Amazon S3 | Terraform remote state |
| GitHub Actions | Continuous Integration & Continuous Deployment |

---

# Infrastructure

```
AWS Cloud
│
├── Amazon VPC
│
├── Public Subnets
│   ├── Internet Gateway
│   ├── NAT Gateway
│   └── Application Load Balancer
│
├── Private Subnets
│   ├── ECS Fargate Tasks
│   └── Amazon RDS
│
├── Amazon ECR
├── Amazon Route53
├── AWS Certificate Manager
├── Amazon CloudWatch
└── AWS IAM
```

---

# Security

## Networking

- ECS tasks run inside private subnets
- Amazon RDS is deployed inside private subnets
- Only the Application Load Balancer is publicly accessible
- NAT Gateway provides outbound internet access without exposing private resources

## HTTPS

- TLS certificates managed by AWS Certificate Manager
- HTTP automatically redirects to HTTPS
- Modern TLS security policy enabled

## Identity

- GitHub Actions authenticates using AWS OpenID Connect (OIDC)
- No AWS access keys stored in GitHub
- Least privilege IAM permissions

## Infrastructure

- Terraform remote state stored securely in Amazon S3
- State locking prevents concurrent deployments
- Infrastructure managed entirely as code

---

# CI/CD Pipelines

## Docker Build & Push

- Builds the Docker image
- Tags the image
- Pushes the image to Amazon ECR

## Terraform Plan

- Terraform formatting check
- Terraform validation
- TFLint
- Terraform plan

## Terraform Deploy

- Authenticates using AWS OpenID Connect
- Initialises Terraform
- Applies infrastructure changes

## Terraform Destroy

- Safely destroys infrastructure
- Removes AWS resources when no longer required

---

# Project Structure

```
.
├── app/
│   ├── application source code
│   └── Dockerfile
│
├── infra/
│   ├── modules/
│   │   ├── acm/
│   │   ├── alb/
│   │   ├── ecr/
│   │   ├── ecs/
│   │   ├── rds/
│   │   ├── route53/
│   │   ├── security/
│   │   └── vpc/
│   │
│   ├── backend.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── main.tf
│
├── .github/
│   └── workflows/
│       ├── build-push.yml
│       ├── terraform-plan.yml
│       ├── terraform-deploy.yml
│       └── terraform-destroy.yml
│
└── README.md
```

---

# Local Development

Clone the repository

```bash
git clone https://github.com/AbdimajidHussein03/snipeit-ecs-deployment.git
```

Navigate into the project

```bash
cd snipeit-ecs-deployment
```

Build the Docker image

```bash
docker build -t snipe-it .
```

Run the container

```bash
docker run -p 8080:80 snipe-it
```

---

# Terraform

Initialise Terraform

```bash
terraform init
```

Validate configuration

```bash
terraform validate
```

Generate an execution plan

```bash
terraform plan
```

Deploy infrastructure

```bash
terraform apply
```

Destroy infrastructure

```bash
terraform destroy
```

---

# Deployment Workflow

```
Developer
     │
     ▼
Push to GitHub
     │
     ▼
Terraform Plan
     │
     ▼
Terraform Deploy
     │
     ▼
Build Docker Image
     │
     ▼
Push to Amazon ECR
     │
     ▼
Amazon ECS Fargate
     │
     ▼
Application Load Balancer
     │
     ▼
HTTPS Application
```

---

# Screenshots

Include screenshots of:

- GitHub Actions pipelines
- Amazon ECS Cluster
- Amazon ECS Service
- Amazon ECS Tasks
- Amazon ECR Repository
- Application Load Balancer
- Target Group
- Amazon RDS
- Route53 Hosted Zone
- AWS Certificate Manager
- CloudWatch Logs
- Running Snipe-IT application

---

# Key Learning Outcomes

This project strengthened my practical experience in:

- Docker containerisation
- Infrastructure as Code (Terraform)
- AWS networking
- Amazon ECS Fargate
- Load balancing
- DNS management
- HTTPS implementation
- IAM security
- GitHub Actions CI/CD
- OpenID Connect (OIDC)
- Terraform remote state management
- Modular infrastructure design
- Production-inspired AWS architecture

---

# Future Improvements

- ECS Auto Scaling
- Blue/Green deployments
- AWS Secrets Manager
- Multi-environment Terraform workspaces
- CloudFront CDN
- AWS WAF
- Rolling ECS deployments after image updates
- CloudWatch dashboards and alarms
