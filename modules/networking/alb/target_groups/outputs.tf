output "gitlab_tg_arn" {
  value = aws_lb_target_group.gitlab_tg.arn
}

output "jenkins_tg_arn" {
  value = aws_lb_target_group.jenkins_tg.arn
}
