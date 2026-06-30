# Snipe-IT on AWS ECS using Terraform & GitHub Actions

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-ECS%20Fargate-FF9900?style=for-the-badge&logo=amazonaws)
![Docker](https://img.shields.io/badge/Docker-Containerised-2496ED?style=for-the-badge&logo=docker)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI/CD-2088FF?style=for-the-badge&logo=githubactions)
![Route53](https://img.shields.io/badge/HTTPS-Enabled-success?style=for-the-badge)

---

# Project Overview

This project demonstrates how a production-style application can be deployed on AWS using Infrastructure as Code and modern DevOps practices.

Instead of deploying infrastructure manually through the AWS Console, the entire environment is provisioned using **Terraform**, allowing every AWS resource to be recreated consistently and automatically.

The application chosen for this project is **Snipe-IT**, an open-source IT asset management platform. The application is containerised with Docker, stored in Amazon Elastic Container Registry (ECR), and deployed onto Amazon ECS Fargate behind an Application Load Balancer secured with HTTPS using AWS Certificate Manager.

Deployment is fully automated through GitHub Actions using OpenID Connect (OIDC), removing the need to store long-lived AWS credentials inside GitHub.

The project follows modern cloud engineering practices including:

- Infrastructure as Code (Terraform)
- Modular Terraform design
- Containerised application deployment
- ECS Fargate orchestration
- HTTPS with ACM
- Route53 DNS management
- Remote Terraform state in Amazon S3
- CI/CD pipelines using GitHub Actions
- Automatic Docker image deployment to Amazon ECR
- Automated infrastructure deployment and destruction

The result is a repeatable deployment process capable of recreating the complete environment from source code.

# Why Snipe-IT?

Rather than building a simple "Hello World" application, I wanted to deploy a real-world open-source application that reflects how containerised workloads are commonly deployed in industry.

Snipe-IT is a widely used IT asset management system that enables organisations to track:

- IT Assets
- Accessories
- Components
- Software Licences
- Users
- Consumables

Deploying a production-ready Laravel application introduced several realistic infrastructure requirements including:

- Persistent database connectivity
- HTTPS termination
- Load balancing
- Container image management
- DNS configuration
- Secure networking
- Infrastructure automation

This made it an excellent project for demonstrating practical AWS and Terraform skills.

# Live Application

Once deployed, the application is available securely over HTTPS.

**Application URL**

```
https://tm.abdimajidcloud.com
```

The deployment uses:

- Amazon Route53
- AWS Certificate Manager
- HTTPS
- Application Load Balancer
- Amazon ECS Fargate

Below is the deployed Snipe-IT dashboard.

## Live Application

![Snipe-IT Dashboard](docs/images/live-dashboard.png)


# Architecture

The infrastructure follows a highly available AWS architecture.

Users access the application over HTTPS using a custom domain managed by Amazon Route53.

Traffic is terminated at an Application Load Balancer where the TLS certificate issued by AWS Certificate Manager is attached.

The load balancer forwards requests to containerised Snipe-IT tasks running on Amazon ECS Fargate inside private subnets.

The application communicates securely with an Amazon RDS MySQL database.

Terraform provisions every AWS resource required to build this environment.

## Architecture Diagram

![Architecture](docs/images/architecture.png)
