

resource "aws_security_group" "variables_demo" {
  name        = "shwatech-variables"
  description = "testing variables in Terraform"
}


resource "aws_vpc_security_group_ingress_rule" "allow_tls" {
  security_group_id = aws_security_group.variables_demo.id
  cidr_ipv4         = var.admin_ip
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.variables_demo.id
  cidr_ipv4         = var.admin_ip
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh" { 
  security_group_id = aws_security_group.variables_demo.id
  cidr_ipv4         = var.admin_ip
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

