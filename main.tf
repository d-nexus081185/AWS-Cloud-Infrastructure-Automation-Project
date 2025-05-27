provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "dev" {
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI in us-east-1 (update if needed)
  instance_type = "t2.micro"
  tags = {
    Name = "DevInstance"
    ENV  = "Development"
  }
}

resource "aws_instance" "prod" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = {
    Name = "ProdInstance"
    ENV  = "Production"
  }
}

output "dev_instance_public_ip" {
  description = "Public IP of the Development EC2 instance"
  value       = aws_instance.dev.public_ip
}

output "prod_instance_public_ip" {
  description = "Public IP of the Production EC2 instance"
  value       = aws_instance.prod.public_ip
}

