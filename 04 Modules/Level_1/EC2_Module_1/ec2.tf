

resource "aws_instance" "shwa_ec2_nano" {
  ami           = "ami-0360c520857e3138f"
  instance_type = "t2.nano"

  tags = {
    Name = "ShwaEC2Nano"
  }
}

