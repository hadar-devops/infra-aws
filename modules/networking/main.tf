module "vpc" {
  source    = "./vpc"
  vpc_cidr  = var.vpc_cidr
  name      = "${var.name_prefix}-vpc"
}

module "public_subnets" {
  source               = "./public_subnets"
  vpc_id               = module.vpc.vpc_id
  public_subnet_cidrs  = var.public_subnet_cidrs
  azs                  = var.azs
  name_prefix          = var.name_prefix
}

module "private_subnets" {
  source                = "./private_subnets"
  vpc_id                = module.vpc.vpc_id
  private_subnet_cidrs  = var.private_subnet_cidrs
  azs                   = var.azs
  name_prefix           = var.name_prefix
}

module "internet_gateway" {
  source      = "./internet_gateway"
  vpc_id      = module.vpc.vpc_id
  name_prefix = var.name_prefix
}

module "nat_gateway" {
  source           = "./nat_gateway"
  public_subnet_id = module.public_subnets.public_subnet_ids[0]
  igw_id           = module.internet_gateway.igw_id
  name_prefix      = var.name_prefix
}

module "public_route_table" {
  source            = "./public_route_table"
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.internet_gateway.igw_id
  public_subnet_ids = module.public_subnets.public_subnet_ids
  name_prefix       = var.name_prefix
}

module "private_route_table" {
  source              = "./private_route_table"
  vpc_id              = module.vpc.vpc_id
  nat_gateway_id      = module.nat_gateway.nat_gateway_id
  private_subnet_ids  = module.private_subnets.private_subnet_ids
  name_prefix         = var.name_prefix
}

module "endpoints" {
  source              = "./endpoints"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.private_subnets.private_subnet_ids
   security_group_ids  = [var.endpoint_sg_id] 
  region              = var.region
  name_prefix         = var.name_prefix

}

resource "aws_security_group" "eks_sg" {
  name        = "${var.name_prefix}-eks-sg"
  description = "Security group for EKS control plane"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-eks-sg"
  }
}

resource "aws_security_group" "node_group_sg" {
  name        = "${var.name_prefix}-node-group-sg"
  description = "Security group for EKS Node Group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_sg.id]
  }

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-node-group-sg"
  }
}


