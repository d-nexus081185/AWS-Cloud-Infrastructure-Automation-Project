provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "dev" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type
  tags = {
    Name = "DevInstance"
    ENV  = "Development"
  }
}

resource "aws_instance" "prod" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type
  tags = {
    Name = "ProdInstance"
    ENV  = "Production"
  }
}

resource "aws_s3_bucket" "website" {
  bucket = "my-static-site-${random_id.bucket_id.hex}"
  website {
    index_document = "index.html"
    error_document = "index.html"
  }
  force_destroy = true
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.website.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.website.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = "*",
      Action = "s3:GetObject",
      Resource = "${aws_s3_bucket.website.arn}/*"
    }]
  })
}

resource "aws_iam_user" "dev_user" {
  name = "dev-ec2-user"
}

resource "aws_iam_group" "dev_group" {
  name = "ec2-dev-access"
}

resource "aws_iam_group_policy" "dev_policy" {
  name  = "dev-ec2-policy"
  group = aws_iam_group.dev_group.name
  policy = file("policy.json")
}

resource "aws_iam_user_group_membership" "dev_membership" {
  user = aws_iam_user.dev_user.name
  groups = [aws_iam_group.dev_group.name]
}

