output "target_group_arn" {
  description = "ARN of the target group created for the load balancer"
  value       = aws_lb_target_group.main.arn

}
