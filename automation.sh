#!/bin/bash

set -euo pipefail

# Define Download URL
DOWNLOAD_URL="https://templatemo.com/download/templatemo_521_get_ready"

# Create Website Asset Directory
mkdir -p assets

# Download the website file using Orginal file name
echo "Downloading Website files from remote Server"
curl -L -O "$DOWNLOAD_URL"

# Find the name of the downloaded file
DOWNLOADED_FILE=$(basename "$DOWNLOAD_URL")

# Unzip the file into the assets folder
echo "Extracting into assets/..."
unzip -o "$DOWNLOADED_FILE" -d assets/

echo "Download and extraction complete."

# Removing extracted file from Directory
rm -rf "$DOWNLOADED_FILE"

# Run Terraform to provision EC2 instances
echo "Initializing and applying Terraform configuration..."
terraform init
terraform plan
terraform apply -auto-approve

echo "Terraform provisioning and IAM setup completed."
