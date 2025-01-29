# Terraform CI/CD Workflow for AWS EKS Deployment  

This repository contains a GitHub Actions workflow for automating Terraform deployments to AWS EKS clusters. The workflow handles multiple environments (`development`, `staging`, and `production`) by selecting or creating the appropriate Terraform workspaces and executing infrastructure provisioning.

---

## 📋 **Table of Contents**  

- [Key Features](#key-features)  
- [Project Structure](#project-structure)  
- [GitHub Actions Workflow](#github-actions-workflow)  
- [Environment Setup](#environment-setup)  
- [Running the Workflow](#running-the-workflow)  
- [Important Commands](#important-commands)  
- [Contributing](#contributing)  

---

## 🚀 **Key Features**  

- **Automated Terraform Workflow:** Runs Terraform commands (`init`, `plan`, and `apply`) for provisioning infrastructure.  
- **Environment-Specific Workspaces:** Dynamically selects or creates Terraform workspaces based on the environment.  
- **Docker Integration:** Builds and pushes Docker images for Kubernetes deployment.  
- **Security Scanning:** Uses Trivy for scanning Docker images.  
- **SonarCloud Integration:** Includes code scanning for code quality and security.  

---

## 📂 **Project Structure**  


---

## ⚙️ **GitHub Actions Workflow**  

The GitHub Actions workflow (`terraform.yml`) is triggered for the following events:  

- **Push Events:** Validates and plans infrastructure changes.  
- **Pull Requests:** Applies a stricter set of validations before merging.  

### Workflow Steps  

1. **Checkout Code:** Fetches the repository code.  
2. **Terraform Setup:** Configures Terraform with the appropriate version.  
3. **Workspace Handling:** Selects or creates the required Terraform workspace based on the environment.  
4. **Plan and Apply:** Runs `terraform plan` and `terraform apply` as needed.  
5. **Kubernetes Deployment:** Updates and validates Kubernetes configurations in EKS.  
6. **Docker Build and Push:** Builds and pushes Docker images.  

---

## 🌍 **Environment Setup**  

Set the following secrets and environment variables in the GitHub repository:  

| **Secret/Variable Name** | **Description**               |
|--------------------------|---------------------------------|
| `AWS_ACCESS_KEY_ID`      | AWS access key ID             |
| `AWS_SECRET_ACCESS_KEY`  | AWS secret access key         |
| `DOCKERHUB_USERNAME`     | DockerHub username            |
| `DOCKERHUB_TOKEN`        | DockerHub authentication token|
| `KUBE_CONFIG_DATA`       | Base64 encoded kubeconfig file|
| `AWS_DEFAULT_REGION`     | AWS region for EKS cluster    |

---

## 🏗️ **Running the Workflow**  

### Triggering Events  

- **Push:** Triggered by pushing changes to `development`, `staging`, or `production` branches.  
- **Pull Requests:** Runs validations before merging pull requests targeting `development`.  

### Customizing Terraform Workspace  
Define the target environment by setting the environment variable `WORKSPACE_NAME`.  

---

## 🛠️ **Important Commands**  

### Initialize Terraform  
```bash
terraform init
terraform workspace select <workspace_name> || terraform workspace new <workspace_name>
terraform plan
terraform apply -auto-approve
```


This `README.md` file provides clarity on the project structure, GitHub Actions workflow, and Terraform commands while being comprehensive and beginner-friendly.

