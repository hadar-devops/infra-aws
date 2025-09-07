variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix for naming subnets"
  type        = string
}
