resource "aws_route53_record" "main_dns" {
  zone_id = var.hosted_zone_id
  name    = "hadarapp.com"
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = true
  }
}
