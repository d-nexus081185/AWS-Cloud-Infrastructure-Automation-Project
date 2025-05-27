# AWS Cloud Infrastructure Automation Project

This project automates the provisioning of AWS infrastructure using Shell scripting, Terraform, and IAM policies via JSON. It demonstrates:

* Website asset downloading
* EC2 provisioning with Terraform
* S3 bucket setup for static website hosting
* IAM policy enforcement using JSON

---

## 🔧 Technologies Used

* **Shell Scripting**
* **Terraform**
* **AWS CLI**
* **Amazon EC2, S3, IAM**

---

## 🚀 Features

1. **Download website assets** from a remote URL and confirm success.
2. **Provision two EC2 instances** using Terraform tagged as:

   * `ENV=Development`
   * `ENV=Production`
3. **Create an S3 bucket** with:

   * Unique name
   * Static website hosting enabled
   * Public access policy
4. **IAM Automation**:

   * IAM user with access **only to Development EC2**
   * IAM group and policy assignment via JSON
5. **Display**:

   * EC2 Public IPs
   * S3 Static Website URL
   * IAM setup summary

---

## 📁 Project Structure

```bash
project-root/
├── automate.sh              # Main bash automation script
├── terraform/
│   ├── main.tf              # Terraform config for EC2
│   ├── variables.tf         # Input variables
│   └── outputs.tf           # Public IP outputs
├── iam/
│   └── dev-access-policy.json # IAM JSON policy
├── assets/
│   └── index.html           # Downloaded website file
└── README.md
```

---

## 🛠️ Prerequisites

* AWS CLI configured with credentials
* Terraform installed
* Bash terminal (Linux/macOS or WSL)

---

## 🔄 How to Run

```bash
chmod +x automate.sh
./automate.sh
```

---

## 📦 Output Example

```
✅ Website downloaded successfully.
Development EC2 IP: 3.91.xxx.xxx
Production EC2 IP:  44.207.xxx.xxx
S3 Website URL:     http://my-static-site-1716827777.s3-website-us-east-1.amazonaws.com
IAM User:           dev-user
IAM Group:          DevEC2AccessGroup
EC2 Access Policy:  ec2:* only for i-1234567890abcdef0
```

---

## 📜 License

MIT License

---

## 👨‍💻 Author

Chukwuemeka Ezeobi

