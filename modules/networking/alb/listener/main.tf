resource "aws_lb_listener" "http" {
  load_balancer_arn = var.alb_arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.jenkins_tg_arn
  }

}

resource "aws_lb_listener_rule" "gitlab_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = var.gitlab_tg_arn
  }

  condition {
    path_pattern {
      values = ["/gitlab*", "/gitlab"]
    }
  }

}


