# Manual AWS Deployment (ClickOps)

Before automating the infrastructure using Terraform and GitHub Actions, I first deployed the application manually through the AWS Management Console (ClickOps). This allowed me to understand how each AWS service worked individually before recreating the entire infrastructure using Infrastructure as Code.

---

## 1. Running the Application Locally

Before deploying to AWS, the application was containerised and tested locally using Docker Desktop.
<img width="1372" height="710" alt="Screenshot 2026-06-21 150643" src="https://github.com/user-attachments/assets/5299a80f-4435-42d7-bf99-a88d58b8ad26" />


---

## 2. Creating an Amazon Elastic Container Registry (ECR)

An Amazon ECR repository was created to store the Docker image for the application.

<img width="1878" height="1007" alt="docker-local-running" src="https://github.com/user-attachments/assets/1895b0c9-86c7-487a-94c6-57bab74f17a7" />


After creating the repository, the Docker image was successfully pushed to Amazon ECR.

<img width="1866" height="877" alt="ecr-repository" src="https://github.com/user-attachments/assets/696e692d-0e01-4890-bfa1-e4b63d2d6583" />


---

## 3. Creating the Amazon ECS Cluster

An Amazon ECS Fargate cluster was configured to host the application without managing EC2 instances.
<img width="1877" height="933" alt="cluster" src="https://github.com/user-attachments/assets/71c2879e-ab79-440b-ac91-89e9f493d889" />


The cluster was then successfully created.
<img width="1547" height="952" alt="ecs-fargate cluster" src="https://github.com/user-attachments/assets/49fbb9d8-d3ee-47db-a7ee-8745dd405914" />


---

## 4. Deploying the ECS Service

An ECS Service was created using the task definition to keep the application running and connect it to the load balancer.

<img width="1536" height="773" alt="ecs service" src="https://github.com/user-attachments/assets/16478f5c-5904-496c-865b-1338991fc873" />


---

## 5. Configuring the Application Load Balancer

A Target Group was created so the Application Load Balancer could route traffic to healthy ECS tasks.
<img width="1882" height="917" alt="Target groups" src="https://github.com/user-attachments/assets/a460bf29-d181-456f-8248-15b18c7edfe3" />


The Application Load Balancer Security Group was configured to allow HTTP (80) and HTTPS (443) traffic.

<img width="1891" height="912" alt="Screenshot 2026-06-21 161311" src="https://github.com/user-attachments/assets/2dae95d4-86f1-4861-b494-e555f424c621" />


---

## 6. Completing the Snipe-IT Installation

After the infrastructure was deployed, Snipe-IT performed a pre-flight check to verify the application configuration before installation.

<img width="1682" height="1067" alt="verify" src="https://github.com/user-attachments/assets/dda86fc4-fdaa-420e-855a-900187c2c71f" />


---

## 7. Accessing the Live Application

Once deployment was complete, the application was accessible securely over HTTPS using the custom domain configured with Route 53 and AWS Certificate Manager (ACM).


<img width="1910" height="1072" alt="snipe-it-dashboard-https" src="https://github.com/user-attachments/assets/cc97f0eb-6662-4216-ac28-9aadaf810dca" />

---

## What I Learned

Building the infrastructure manually helped me understand the relationship between the AWS services before automating everything with Terraform.

Key services explored included:

- Docker
- Amazon Elastic Container Registry (ECR)
- Amazon ECS Fargate
- Application Load Balancer (ALB)
- Target Groups
- Security Groups
- Amazon Route 53
- AWS Certificate Manager (ACM)
- HTTPS/TLS
- CloudWatch Logs

After successfully completing the manual deployment, the entire infrastructure was recreated using Terraform modules and automated with GitHub Actions CI/CD pipelines.
