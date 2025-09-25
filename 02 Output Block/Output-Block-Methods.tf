
# ========================================================
# Example Terraform configuration for Output Block Methods
# ========================================================

resource "aws_s3_bucket" "shwa_s3" {
  bucket = "shwa-s3-bucket-111111"
}

resource "aws_vpc" "shwa_vpc" {
  cidr_block = "10.0.0.0/16"
}

output "s3_arn" {
  value = aws_s3_bucket.shwa_s3.arn
}

output "vpc_id" {
  value = aws_vpc.shwa_vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.shwa_vpc.cidr_block
}


# =========================
# Terraform Random Password
# =========================

resource "random_password" "shwa_password" {
  length = 16
  special = true
}

output "SHWA_PWD" {
  value     = random_password.shwa_password.result
  sensitive = true
}


# =======================
# Terraform Random String
# =======================

resource "random_string" "shwa_string" {
  length  = 16
  special = true
}

output "SHWA_STRING" {
  value = random_string.shwa_string.result
  # sensitive = true
}

