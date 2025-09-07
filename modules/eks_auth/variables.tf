variable "node_group_role_arn" {
  type = string
  description = "ARN of the Node Group IAM Role"
}

variable "jenkins_agent_role_arn" {
  type = string
  description = "ARN of the Jenkins Agent IAM Role"
}

variable "alb_controller_role_arn" {
  type = string
}