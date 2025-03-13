# resource "aws_lb" "ingress" {

#   name = var.prefix

#   internal           = false
#   load_balancer_type = "network"

#   subnets = var.subnet_ids

#   enable_cross_zone_load_balancing = true
#   enable_deletion_protection       = false

#   tags = {
#     Name = var.prefix
#   }

# }

# resource "aws_lb_target_group" "main" {
#   name     = format("%s-http", var.prefix)
#   port     = 8080
#   protocol = "TCP"
#   vpc_id   = var.vpc_id
# }

# resource "aws_lb_listener" "main" {
#   load_balancer_arn = aws_lb.ingress.arn
#   port              = 80
#   protocol          = "TCP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.main.arn
#   }
# }
resource "aws_ec2_tag" "public_subnet_tags" {
  for_each    = toset(var.subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}
