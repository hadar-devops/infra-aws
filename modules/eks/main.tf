module "iam" {
  source = "./iam"
  name_prefix = var.name_prefix
}

module "cluster" {
  source = "./cluster"

  cluster_name         = var.name_prefix
  kubernetes_version   = var.kubernetes_version
  private_subnet_ids   = var.private_subnet_ids
  cluster_iam_role_arn = module.iam.cluster_role_arn
  cluster_sg_id        = var.cluster_sg_id
  
}

module "node_group" {
  source = "./node_group"

  node_group_name      = "${var.name_prefix}-ng"
  cluster_name         = module.cluster.cluster_name
  node_role_arn        = var.node_group_role_arn
  subnet_ids           = var.private_subnet_ids
  instance_types       = ["t3.medium"]
  desired_size         = 2
  min_size             = 1
  max_size             = 3
  node_group_sg_id     = var.node_group_sg_id
  region = var.region
}

# module "aws_auth" {
#   source = "./eks_auth"

#   node_group_role_arn    = var.node_group_role_arn
#   jenkins_agent_role_arn = var.jenkins_agent_role_arn
#   alb_controller_role_arn = var.alb_controller_role_arn
# }

