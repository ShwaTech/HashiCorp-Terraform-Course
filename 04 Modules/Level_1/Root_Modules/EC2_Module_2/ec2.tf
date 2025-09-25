

resource "aws_instance" "shwa_ec2_micro" {
  ami           = "ami-0360c520857e3138f"
  instance_type = "t2.micro"

  tags = {
    Name = "ShwaEC2Micro"
  }
}

