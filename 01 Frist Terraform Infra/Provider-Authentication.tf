
# # Configure the AWS Provider with static credentials
# # This Method is not recommended for production use due to security reasons.
# # Instead, consider using environment variables, shared credentials file, or IAM roles.
# provider "aws" {
#   region     = "us-west-2"
#   access_key = "my-access-key"
#   secret_key = "my-secret-key"
# }


# # Configure the AWS Provider for a specific profile
# provider "aws" {
#   region = "us-east-1"
#   profile = "shwa-aws"
# }


# # Configure the AWS Provider using environment variables
# # Make sure to set the environment variables before running Terraform
# provider "aws" {}
# $ export AWS_ACCESS_KEY_ID="anaccesskey"
# $ export AWS_SECRET_ACCESS_KEY="asecretkey"
# $ export AWS_REGION="us-west-2"
# $ terraform plan


# # Configure the AWS Provider using shared credentials file and config file
# # Make sure to set up the ~/.aws/credentials and ~/.aws/config files properly
# provider "aws" {
#   shared_config_files      = ["~/.aws/config"]
#   shared_credentials_files = ["~/.aws/credentials"]
#   profile                  = "customprofile"
# }


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


# Create a VPC
resource "aws_vpc" "vpc_tf" {
  cidr_block = "10.0.0.0/16"
}


# Create an AWS Instance EC2
resource "aws_instance" "tf_ec2" {
  ami           = "ami-0360c520857e3138f"
  instance_type = "t2.micro"

  tags = {
    Name = "MyFirstTFInstance"
  }
}


## ===================
## Terraform Resources
## =================== 

# Create another VPC with tags
# resource "aws_vpc" "shwa_VPC" {
#   cidr_block = "10.0.0.0/16"

#   tags = {
#     Name = "SHWA_VPC"
#   }
# }

# # Create a Subnet in the VPC
# resource "aws_subnet" "main" {
#   vpc_id     = aws_vpc.shwa_VPC.id
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "SHWA_Subnet"
#   }
# }

# resource "aws_s3_bucket" "shwa_bucket" {
#   bucket = "shwa-terraform-storage-bucket" # Bucket names must be globally unique

#   tags = {
#     Name        = "SHWA_Bucket"
#     Environment = "Dev"
#   }
# }


## ===============================
## Terraform Resource Dependencies
## ===============================

# ------------------------------
# Example 1: Implicit Dependency
# ------------------------------

resource "aws_eip" "shwa_eip" {
  domain = "vpc"
  instance = aws_instance.tf_ec2.id
}


# ------------------------------
# Example 2: Explicit Dependency
# ------------------------------

resource "aws_eip" "shwa_eip" {
  domain = "vpc"

  depends_on = [aws_instance.tf_ec2]
}

