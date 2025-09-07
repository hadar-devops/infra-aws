variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix for naming the route table"
  type        = string
}
