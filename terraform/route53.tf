resource "aws_route53_zone" "private" {
  name = "test.local"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  comment = "Private zone for test.local"
}

resource "aws_route53_record" "app_alias" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "test.local"
  type    = "A"

  alias {
    name                   = aws_lb.app_alb.dns_name
    zone_id                = aws_lb.app_alb.zone_id
    evaluate_target_health = true
  }
}
