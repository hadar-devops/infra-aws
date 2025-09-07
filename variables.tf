variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
}

variable "vpc_cidr" {}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}


variable "azs" {
  type = list(string)
}

variable "region" {
  description = "AWS region"
  type        = string
}


variable "gitlab_ami_id" {
  type = string
  description = "AMI ID for GitLab"
}
variable "jenkins_controller_ami_id" {
  type = string
  description = "AMI ID for Jenkins Controller"
}
variable "jenkins_agent_ami_id" {
  type = string
  description = "AMI ID for Jenkins Agent"
}

variable "hosted_zone_id" {
  description = "Public hosted zone ID of hadarapp.be"
  type        = string
}

variable "domain_name" {
  description = "Main domain name"
  default     = "hadarapp.be"
}

variable "cluster_name" {
  type = string
}

