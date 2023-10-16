resource "aws_security_group" "common-us-east-1" {
  name        = "${var.resourcePrefix}-common"
  description = "common sg"
  vpc_id      = module.vpc-us-east-1.vpc.id

  egress {
    description = "https to internet"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.resourcePrefix}-common"
  }
}
