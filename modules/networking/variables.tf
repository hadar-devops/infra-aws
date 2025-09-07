variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "endpoint_sg_id" {
  description = "Security Group ID for the endpoints"
  type        = string
}


variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}





