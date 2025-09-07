module "target_groups" {
  source              = "./target_groups"
  name_prefix         = var.name_prefix
  vpc_id              = var.vpc_id
  gitlab_instance_id  = var.gitlab_instance_id
  jenkins_instance_id = var.jenkins_instance_id
}

module "listener" {
  source         = "./listener"
  alb_arn        = aws_lb.main.arn
  gitlab_tg_arn  = module.target_groups.gitlab_tg_arn
  jenkins_tg_arn = module.target_groups.jenkins_tg_arn
}

resource "aws_lb" "main" {
  name               = "${var.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "${var.name_prefix}-alb"
  }

}

