

output "Sec_Grp_ID" {
  value = aws_security_group.shwaSG.id
}

resource "aws_security_group" "shwaSG" {
  name        = "shwaSG"
  description = "Security group for allowing SSH and HTTP access"

  ingress {
    description = "Allow Inbound To My Application"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols (AllTraffic)
    cidr_blocks = ["0.0.0.0/0"]
  }
}

