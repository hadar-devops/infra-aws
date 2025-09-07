variable "public_subnet_id" {
  description = "ID of the public subnet to place the NAT Gateway"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for naming the NAT and EIP"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway ID (used for dependency)"
  type        = string
}
