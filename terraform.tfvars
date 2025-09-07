name_prefix         = "hadar"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
azs                 = ["eu-central-1a", "eu-central-1b"]
region              = "eu-central-1"
gitlab_ami_id              = "ami-0514e03bb2ef89d94"
jenkins_controller_ami_id  = "ami-03f891005134e425d"
jenkins_agent_ami_id       = "ami-01cc8f0a2eeee1d10"
hosted_zone_id = "Z103260830PKAJOWUNCOH"
domain_name    = "hadarapp.com"
cluster_name = "hadar-cluster"

