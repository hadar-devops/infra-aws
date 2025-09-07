variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
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
