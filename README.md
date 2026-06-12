# CSE632 Final Project
## Overview
NGINX deployed in Docker containers managed by Kubernetes (EKS) on AWS.
## Stack
- **Infrastructure**: Terraform (VPC, Subnets)
- **Kubernetes**: Amazon EKS
- **Webserver**: NGINX in Docker containers
- **CI/CD**: GitHub (branch: final)

## Project Structure
cse632-0626-final/

├── terraform/        # VPC infrastructure

│   ├── main.tf

│   ├── variables.tf

│   └── outputs.tf

├── k8s/              # Kubernetes manifests

│   ├── deployment.yaml

│   └── service.yaml

├── index.html        # Website

└── README.md


## Deployment Steps
1. `terraform init && terraform apply`
2. `eksctl create cluster --name cse632-cluster`
3. `kubectl create configmap nginx-html --from-file=index.html`
4. `kubectl apply -f k8s/`
5. `kubectl get service nginx-service` (get public URL)
