# resource "aws_lb" "ingress" {

#   name = var.prefix

#   internal           = false
#   load_balancer_type = "application"

#   subnets = var.subnet_ids

#   enable_cross_zone_load_balancing = true
#   enable_deletion_protection       = false

#   tags = {
#     Name                                              = var.prefix
#     "kubernetes.io/cluster/${var.prefix}-eks-cluster" = "shared"
#     "elbv2.k8s.aws/cluster"                           = "${var.prefix}-eks-cluster"
#   }
#   lifecycle {
#     ignore_changes = [
#       access_logs,
#     ]
#   }
# }

# resource "aws_lb_listener" "redirect_http_to_https" {
#   load_balancer_arn = aws_lb.ingress.arn
#   port              = "80"
#   protocol          = "HTTP"

#   # Default action: redirect HTTP to HTTPS
#   default_action {
#     type = "redirect"
#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }

#   # Let ingress controller manage rules
#   lifecycle {
#     ignore_changes = [default_action]
#   }
# }

resource "aws_ec2_tag" "public_subnet_tags" {
  for_each    = toset(var.subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}

