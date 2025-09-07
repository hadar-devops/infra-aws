variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "alb_sg_id" {
  description = "Security Group for the ALB"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID used for the Target Groups"
  type        = string
}

variable "gitlab_instance_id" {
  description = "ID of the GitLab EC2 instance"
  type        = string
}

variable "jenkins_instance_id" {
  description = "ID of the Jenkins Controller EC2 instance"
  type        = string
}
