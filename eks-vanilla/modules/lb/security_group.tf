# modules/lb/security_group.tf - New file

# Data source to get VPC info
data "aws_vpc" "main" {
  id = var.vpc_id
}

# Security Group for ALB
resource "aws_security_group" "alb" {
  name_prefix = "${var.prefix}-alb-"
  description = "Security group for ALB ${var.prefix}"
  vpc_id      = var.vpc_id

  # Inbound Rules
  # HTTP from anywhere
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS from anywhere
  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rules


  # Allow ALB to reach NodePort range (30000-32767)
  egress {
    description = "NodePort range to targets"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "${var.prefix}-alb-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}
