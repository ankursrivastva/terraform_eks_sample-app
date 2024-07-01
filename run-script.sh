#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Initialize Terraform
terraform init

# Apply the Terraform configuration
terraform apply -auto-approve

# Get the EKS cluster name and region from Terraform outputs
CLUSTER_NAME=$(terraform output -raw cluster_name)
REGION=$(terraform output -raw region)

# Update kubeconfig to use the new EKS cluster
aws eks --region $REGION update-kubeconfig --name $CLUSTER_NAME

# Wait for the service to get an external IP
echo "Waiting for the service to get an external IP..."
EXTERNAL_IP=""
while [ -z "$EXTERNAL_IP" ]; do
  echo "Checking for external IP..."
  EXTERNAL_IP=$(kubectl get svc fortune-api -n default -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
  [ -z "$EXTERNAL_IP" ] && sleep 10
done

# Output the external IP
echo "The application is accessible at: http://$EXTERNAL_IP"

