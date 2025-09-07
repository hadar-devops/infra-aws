variable "name_prefix" { type = string }

variable "private_subnet_ids" { type = list(string) }
variable "public_subnet_ids"  { type = list(string) }
variable "vpc_id"             { type = string }

variable "cluster_sg_id" { type = string }
variable "cluster_sg_name" { type = string }

variable "node_group_sg_id" { type = string }
variable "node_group_sg_name" { type = string }

variable "kubernetes_version" {
  type    = string
  default = "1.29"
}

variable "region" {
  type = string
}

variable "node_group_role_arn" {
  description = "ARN of the Node Group IAM Role"
  type        = string
}

# variable "jenkins_agent_role_arn" {
#   description = "ARN of the Jenkins Agent IAM Role"
#   type        = string
# }

# variable "alb_controller_role_arn" {
#   type = string
# }

