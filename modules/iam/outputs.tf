output "ssm_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_ssm_profile.name
}

output "jenkins_agent_instance_profile" {
  value = aws_iam_instance_profile.jenkins_agent_instance_profile.name
}

output "jenkins_agent_role_arn" {
  value = aws_iam_role.jenkins_agent_role.arn
}

output "node_group_role_arn" {
  description = "ARN of the EKS node group IAM role"
  value       = aws_iam_role.node_group_role.arn
}

output "alb_controller_role_arn" {
  value = aws_iam_role.alb_controller.arn
}
