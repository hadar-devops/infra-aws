provider "aws" {
  region = var.region
}

resource "aws_security_group" "endpoints" {
  name        = "${var.name_prefix}-endpoints-sg"
  description = "Security group for VPC endpoints"
  vpc_id      = module.networking.vpc_id  

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-endpoints-sg"
  }

 
}

module "networking" {
  source              = "./modules/networking"
  name_prefix         = var.name_prefix
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                 = var.azs
  region              = var.region
  endpoint_sg_id       = aws_security_group.endpoints.id
  private_subnet_ids = module.networking.private_subnet_ids
}

resource "aws_security_group" "gitlab_sg" {
  name        = "${var.name_prefix}-gitlab-sg"
  description = "Open all traffic for GitLab"
  vpc_id      = module.networking.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-gitlab-sg"
  }


}

module "gitlab_instance" {
  source                = "./modules/compute/ec2_instance"
  ami_id                = var.gitlab_ami_id
  instance_type         = "t3.medium"
  subnet_id = module.networking.private_subnet_ids[0]
  security_group_ids    = [aws_security_group.gitlab_sg.id]
  instance_profile_name = module.iam.ssm_instance_profile_name
  name                  = "${var.name_prefix}-gitlab"
}

resource "aws_security_group" "jenkins_controller_sg" {
  name        = "${var.name_prefix}-jenkins-controller-sg"
  description = "Open all traffic for Jenkins Controller"
  vpc_id      = module.networking.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-jenkins-controller-sg"
  }


}

module "jenkins_controller_instance" {
  source                = "./modules/compute/ec2_instance"
  ami_id                = var.jenkins_controller_ami_id
  instance_type         = "t3.medium"
  subnet_id = module.networking.private_subnet_ids[0]
  security_group_ids    = [aws_security_group.jenkins_controller_sg.id]
  instance_profile_name = module.iam.ssm_instance_profile_name
  name                  = "${var.name_prefix}-jenkins-controller"
}

resource "aws_security_group" "jenkins_agent_sg" {
  name        = "${var.name_prefix}-jenkins-agent-sg"
  description = "Open all traffic for Jenkins Agent"
  vpc_id      = module.networking.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_prefix}-jenkins-agent-sg"
  }


}

module "jenkins_agent_instance" {
  source                = "./modules/compute/ec2_instance"
  ami_id                = var.jenkins_agent_ami_id
  instance_type         = "t3.medium"
  subnet_id = module.networking.private_subnet_ids[0]
  security_group_ids    = [aws_security_group.jenkins_agent_sg.id]
  instance_profile_name = module.iam.jenkins_agent_instance_profile
  name                  = "${var.name_prefix}-jenkins-agent"
}



resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.networking.vpc_id 

  ingress {
    from_port   = 80
    to_port     = 80
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
    Name = "alb-sg"
  }

}


module "alb" {
  source              = "./modules/networking/alb"
  name_prefix         = "myapp"

  alb_sg_id = aws_security_group.alb_sg.id
  public_subnet_ids   = module.networking.public_subnet_ids

  vpc_id              = module.networking.vpc_id
  gitlab_instance_id  = module.gitlab_instance.instance_id
  jenkins_instance_id = module.jenkins_controller_instance.instance_id
}


module "eks" {
  source = "./modules/eks"

  name_prefix           = var.name_prefix
  private_subnet_ids    = module.networking.private_subnet_ids
  public_subnet_ids     = module.networking.public_subnet_ids
  vpc_id                = module.networking.vpc_id
  cluster_sg_id         = module.networking.eks_sg_id
  cluster_sg_name       = "eks-cluster-sg"
  node_group_sg_id      = module.networking.node_group_sg_id
  node_group_sg_name    = "eks-ng-sg"
  region                = var.region
  node_group_role_arn     = module.iam.node_group_role_arn
  #jenkins_agent_role_arn  = module.iam.jenkins_agent_role_arn

}


data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_ca_certificate)
  token                  = data.aws_eks_cluster_auth.token.token
}

data "aws_eks_cluster_auth" "token" {
  name = module.eks.cluster_name
}


module "iam" {
  source        = "./modules/iam"
  name_prefix   = var.name_prefix
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.cluster_oidc_url
}

module "eks_auth" {
  node_group_role_arn       = module.iam.node_group_role_arn
  jenkins_agent_role_arn    = module.iam.jenkins_agent_role_arn
  source                  = "./modules/eks_auth"
  alb_controller_role_arn = module.iam.alb_controller_role_arn
}