#!/bin/bash

set -euo pipefail

# Get user input for AWS region and instance type
read -p "Enter AWS region (default: us-east-1): " AWS_REGION
read -p "Enter EC2 instance type (default: t2.micro): " INSTANCE_TYPE

AWS_REGION=${AWS_REGION:-us-east-1}
INSTANCE_TYPE=${INSTANCE_TYPE:-t2.micro}

# Save parameters to a Terraform variable file
cat > terraform.tfvars <<EOF
aws_region = "$AWS_REGION"
instance_type = "$INSTANCE_TYPE"
EOF

# Define Download URL
DOWNLOAD_URL="https://templatemo.com/download/templatemo_521_get_ready"

mkdir -p assets

echo "📥 Downloading Website template..."
curl -L -o website_template.zip "$DOWNLOAD_URL"

echo "📂 Extracting into assets/..."
unzip -o website_template.zip -d assets/
rm website_template.zip

# Initialize and apply Terraform
echo "🚀 Running Terraform..."
terraform init
terraform apply -var-file="terraform.tfvars" -auto-approve

# Get Terraform outputs
DEV_IP=$(terraform output -raw dev_public_ip)
PROD_IP=$(terraform output -raw prod_public_ip)
S3_URL=$(terraform output -raw website_url)
IAM_USER=$(terraform output -raw iam_user_name)

echo ""
echo "✅ Deployment Complete!"
echo "=============================="
echo "🖥 Dev EC2 Public IP: $DEV_IP"
echo "🖥 Prod EC2 Public IP: $PROD_IP"
echo "🌐 S3 Website URL: $S3_URL"
echo "👤 IAM User: $IAM_USER"
echo "=============================="

