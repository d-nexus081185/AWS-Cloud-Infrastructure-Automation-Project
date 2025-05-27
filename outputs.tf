output "dev_public_ip" {
  value = aws_instance.dev.public_ip
}

output "prod_public_ip" {
  value = aws_instance.prod.public_ip
}

output "website_url" {
  value = "http://${aws_s3_bucket.website.bucket}.s3-website-${var.aws_region}.amazonaws.com"
}

output "iam_user_name" {
  value = aws_iam_user.dev_user.name
}

