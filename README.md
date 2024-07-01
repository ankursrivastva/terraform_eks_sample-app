# EKS Cluster Setup and wego Application Deployment

This project automates the creation of an Amazon EKS cluster, deployment of an application, and configuration of kubectlusing Terraform and a bash script.

## Prerequisites

- Terraform
- kubectl
- AWS CLI

## AWS Configuration

1. **Configure AWS CLI:**

   After installing the AWS CLI, configure it with your credentials:

   ```bash
   aws configure

2. git clone https://github.com/ankursrivastva/terraform_eks_sample-app.git
   cd terraform_eks_sample-app

3. chmod +x run-script.sh
   ./run-script.sh

4. Wait for the output of run-script.sh which will contain the service API endpoint

