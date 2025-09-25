
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


# ========================
# deponds_on meta-argument
# ========================

resource "aws_vpc" "shwa_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "shwa_subnet" {
  vpc_id     = aws_vpc.shwa_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "SHWA_Subnet"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.shwa_vpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.shwa_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "shwa_ec2" {
  ami           = "ami-0360c520857e3138f"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.shwa_subnet.id
  associate_public_ip_address = "true"
  vpc_security_group_ids = [ aws_security_group.allow_tls.id ]

  tags = {
    Name = "SHWA_Instance"
  }
}

output "ec2_public" {
  value = aws_instance.shwa_ec2.public_ip
  depends_on = [ aws_vpc_security_group_ingress_rule.allow_tls ]
}


