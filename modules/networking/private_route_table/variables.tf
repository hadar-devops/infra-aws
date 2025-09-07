variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix for naming the route table"
  type        = string
}
