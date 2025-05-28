data "kubernetes_service" "istio_gateway" {
  metadata {
    name      = "istio-ingressgateway"
    namespace = "istio-system"
  }

}

locals {
  # Extract the NodePort for status-port (15021)
  status_nodeport = [
    for port in data.kubernetes_service.istio_gateway.spec[0].port :
    port.node_port if port.name == "status-port"
  ][0]
}

resource "aws_lb" "ingress" {
  name = var.prefix

  internal           = false
  load_balancer_type = "application"

  subnets = var.subnet_ids

  # Use our dedicated security group
  security_groups = [aws_security_group.alb.id]

  enable_deletion_protection = false

  tags = {
    Name                                              = var.prefix
    "kubernetes.io/cluster/${var.prefix}-eks-cluster" = "shared"
    "elbv2.k8s.aws/cluster"                           = "${var.prefix}-eks-cluster"
  }

  lifecycle {
    ignore_changes = [access_logs]
  }
}

# HTTP Listener - Redirect to HTTPS
resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.ingress.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# HTTPS Listener
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.ingress.arn
  port              = "443"
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

# Target Group - TargetGroupBinding will override health check settings
resource "aws_lb_target_group" "main" {
  name     = format("%s-http", var.prefix)
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 15
    matcher             = "200"
    path                = "/healthz/ready"
    port                = local.status_nodeport # Dynamic NodePort
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3
  }

  tags = {
    Name = format("%s-http", var.prefix)
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Tag subnets for ALB
resource "aws_ec2_tag" "public_subnet_tags" {
  for_each    = toset(var.subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}
