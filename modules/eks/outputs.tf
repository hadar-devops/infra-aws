output "cluster_name" {
  value = module.cluster.cluster_name
}

output "cluster_endpoint" {
  value = module.cluster.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.cluster.cluster_ca_certificate
}

output "cluster_role_arn" {
  value = module.iam.cluster_role_arn
}

output "oidc_provider_arn" {
  value = module.cluster.oidc_provider_arn
}

output "cluster_oidc_url" {
  value = module.cluster.cluster_oidc_url
}


