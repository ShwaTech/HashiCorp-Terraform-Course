
resource "aws_vpc" "shwa_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "SHWA_VPC"
  }
}


resource "aws_network_acl" "shwa_nacl" {
  vpc_id = aws_vpc.shwa_vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "SHWA_NACL"
  }
}


