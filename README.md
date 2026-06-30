# Snipe-IT Asset Management Platform on AWS

> A production-style DevOps project demonstrating how a containerised Snipe-IT application can be deployed to AWS using Docker, Terraform, Amazon ECS (Fargate) and GitHub Actions.

---

## Table of Contents

- Project Overview
- Project Objectives
- Features
- Technologies Used
- AWS Services
- Architecture Overview
- Architecture Diagram
- Repository Structure
- Local Development
- ClickOps Phase
- Infrastructure as Code
- Bootstrap Infrastructure
- Terraform Modules
- CI/CD Pipelines
- Live Application
- Security
- Challenges & Lessons Learned
- Future Improvements
- Conclusion

---

# Project Overview

This project demonstrates a complete end-to-end deployment of the open-source **Snipe-IT Asset Management System** onto Amazon Web Services using modern DevOps practices.

Rather than simply deploying an application manually, the primary objective was to build a production-style deployment pipeline that automates both the application delivery process and the infrastructure provisioning process.

The application is containerised using Docker before being pushed into **Amazon Elastic Container Registry (ECR)**.

Infrastructure is managed entirely using **Terraform**, allowing every AWS resource to be recreated consistently and repeatedly through Infrastructure as Code.

Deployment is fully automated using **GitHub Actions**, which build the Docker image, provision AWS infrastructure, deploy the application to Amazon ECS, and securely expose the application over HTTPS using an Application Load Balancer and AWS Certificate Manager.

The project follows real-world DevOps practices by implementing:

- Infrastructure as Code
- Modular Terraform architecture
- Remote Terraform state
- GitHub OIDC authentication
- Continuous Integration
- Continuous Deployment
- HTTPS encryption
- Custom domain
- Reusable Terraform modules

---

# Project Objectives

The primary objectives of this project were:

- Deploy an open-source application using Docker
- Build custom Terraform modules for AWS infrastructure
- Automate infrastructure deployment
- Automate application deployment
- Implement GitHub Actions CI/CD pipelines
- Configure a secure HTTPS endpoint
- Use a custom Route53 domain
- Store Terraform state remotely
- Authenticate GitHub securely using OpenID Connect (OIDC)
- Structure the project following production-style DevOps practices

---

# Features

✔ Dockerised Snipe-IT application

✔ Amazon ECS (Fargate)

✔ Amazon Elastic Container Registry (ECR)

✔ Application Load Balancer

✔ HTTPS using AWS Certificate Manager

✔ Route53 custom domain

✔ Terraform Infrastructure as Code

✔ Reusable Terraform modules

✔ Remote Terraform backend

✔ Terraform state locking

✔ GitHub Actions automation

✔ OIDC authentication

✔ Automated Docker builds

✔ Automated Terraform deployment

✔ Automated Terraform destruction

---

# Technologies Used

| Technology | Purpose |
|------------|---------|
| Docker | Containerisation |
| GitHub Actions | CI/CD |
| Terraform | Infrastructure as Code |
| AWS ECS (Fargate) | Container orchestration |
| Amazon ECR | Container image registry |
| Route53 | DNS |
| ACM | SSL/TLS Certificates |
| Application Load Balancer | Traffic distribution |
| Amazon RDS | Database |
| Amazon S3 | Terraform backend |
| IAM | Permissions |
| Git | Version Control |
| GitHub | Repository Hosting |

---

# AWS Services Used

This project combines several AWS services that work together to provide a secure, scalable and automated deployment.

## Amazon ECS (Fargate)

Amazon ECS is responsible for running the Snipe-IT container.

Rather than managing EC2 instances manually, the project uses the **Fargate launch type**, allowing AWS to manage the underlying infrastructure while only requiring the container configuration.

This significantly reduces operational overhead and makes deployments much simpler.

---

## Amazon Elastic Container Registry (ECR)

Amazon ECR stores the Docker images built by the GitHub Actions application pipeline.

Whenever code is pushed to GitHub, a new Docker image is automatically built and pushed into ECR.

Amazon ECS then pulls the latest image directly from ECR during deployment.

---

## Application Load Balancer

The Application Load Balancer acts as the public entry point to the application.

Its responsibilities include:

- Accepting HTTPS traffic
- Terminating SSL
- Forwarding requests to ECS
- Performing health checks
- Distributing traffic across ECS tasks

---

## AWS Certificate Manager (ACM)

AWS Certificate Manager automatically provisions and manages the TLS certificate used by the Application Load Balancer.

Terraform also automates the certificate validation process using Route53 DNS validation records.

This removes the need to manually manage SSL certificates.

---

## Amazon Route53

Route53 provides DNS management for the application.

Terraform automatically creates:

- Hosted Zone records
- Certificate validation records
- ALB Alias Record

allowing the application to be accessed through the custom domain over HTTPS.

---

## Amazon RDS

Amazon RDS provides a managed MySQL database for Snipe-IT.

Running the database separately from the application ensures persistent storage while allowing ECS tasks to remain stateless.

---

## Amazon S3

An S3 bucket is used as the remote Terraform backend.

This stores the Terraform state securely outside the local machine and enables consistent infrastructure management across environments.

---

## AWS IAM

IAM manages permissions throughout the project.

It is responsible for:

- GitHub OIDC Role
- ECS Task Execution Role
- ECS Task Role
- Terraform Deployment Permissions

Following the principle of least privilege helps improve the overall security of the deployment.

---

# Architecture Overview

The deployment follows a layered AWS architecture.

Users access the application through a custom Route53 domain secured with HTTPS.

Requests are forwarded to an Application Load Balancer, which distributes traffic to ECS Fargate tasks running the Snipe-IT application inside private subnets.

The application communicates securely with an Amazon RDS MySQL database located in isolated database subnets.

Container images are pulled from Amazon Elastic Container Registry, while Terraform stores its remote state inside Amazon S3.

The entire infrastructure is deployed automatically using reusable Terraform modules and GitHub Actions pipelines.

---

# Architecture Diagram

> 📸 **Apply Screenshot:** `diagram.png`

The following diagram illustrates the complete AWS architecture used throughout this project.

It demonstrates the interaction between Route53, ACM, the Application Load Balancer, ECS Fargate, Amazon RDS, Terraform, and GitHub Actions.
