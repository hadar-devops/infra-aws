output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.main.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.main.arn
}

output "gitlab_target_group_arn" {
  description = "ARN of the GitLab Target Group"
  value       = module.target_groups.gitlab_tg_arn
}

output "jenkins_target_group_arn" {
  description = "ARN of the Jenkins Target Group"
  value       = module.target_groups.jenkins_tg_arn
}


output "listener_arn" {
  description = "ARN of the HTTP listener"
  value       = module.listener.listener_arn
}

output "alb_zone_id" {
  value = aws_lb.main.zone_id
}