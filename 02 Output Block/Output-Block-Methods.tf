
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
  length  = 16
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

resource "aws_vpc" "mo_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "mo_subnet" {
  vpc_id            = aws_vpc.mo_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "SHWA_Subnet"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.mo_vpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.mo_vpc.cidr_block
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
  ami                         = "ami-0360c520857e3138f"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.mo_subnet.id
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]

  tags = {
    Name = "SHWA_Instance"
  }
}

output "ec2_public" {
  value      = aws_instance.shwa_ec2.public_ip
  depends_on = [aws_vpc_security_group_ingress_rule.allow_tls]
}


# ================
# Terraform Blocks
# ================

terraform {
  required_version = "=1.13.3"
  required_providers {
    shwa-cloud = {
      source  = "hashicorp/aws"
      version = "=6.14.1"
    }
  }
}

provider "shwa-cloud" {
  region = "us-east-1"
}


# ======================
# Terraform Data Sources
# ======================

data "aws_region" "current" {}

output "current_region" {
  value = data.aws_region.current.id
}

data "aws_regions" "currents" {}

output "current_regions" {
  value = data.aws_regions.currents.names
}

data "aws_availability_zones" "available" {}

output "available_zones" {
  value = data.aws_availability_zones.available.names[*]
}

# Useful to get the latest AMI ID for EC2 instance creation
data "aws_ami" "shwa_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "latest_ami_id" {
  value = data.aws_ami.shwa_ami.id
}

output "latest_ami_name" {
  value = data.aws_ami.shwa_ami.name
}


resource "aws_instance" "shwa_instance" {
  ami           = data.aws_ami.shwa_ami.id
  instance_type = "t2.micro"

  tags = {
    Name = "SHWADepOps_Instance"
  }
  
}

