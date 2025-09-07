output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_ca" {
  value = module.eks.cluster_ca_certificate
}
