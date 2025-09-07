output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.public_subnets.public_subnet_ids
}


output "nat_gateway_id" {
  value = module.nat_gateway.nat_gateway_id
}

output "igw_id" {
  value = module.internet_gateway.igw_id
}



output "private_subnet_ids" {
  value = module.private_subnets.private_subnet_ids
}

output "eks_sg_id" {
  value = aws_security_group.eks_sg.id
}

output "node_group_sg_id" {
  value = aws_security_group.node_group_sg.id
}



