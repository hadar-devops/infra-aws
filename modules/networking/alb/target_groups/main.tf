resource "aws_lb_target_group" "gitlab_tg" {
  name        = "${var.name_prefix}-gitlab-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/gitlab/users/sign_in"
    protocol            = "HTTP"
    port                = "80"
    matcher             = "200-399"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }
}

resource "aws_lb_target_group" "jenkins_tg" {
  name        = "${var.name_prefix}-jenkins-tg"
  port        = 8080
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/login"
    protocol            = "HTTP"
    port                = "8080"
    matcher             = "200-399"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
  }

}


resource "aws_lb_target_group_attachment" "gitlab_attachment" {
  target_group_arn = aws_lb_target_group.gitlab_tg.arn
  target_id        = var.gitlab_instance_id
  port             = 80

}

resource "aws_lb_target_group_attachment" "jenkins_attachment" {
  target_group_arn = aws_lb_target_group.jenkins_tg.arn
  target_id        = var.jenkins_instance_id
  port             = 8080

}

