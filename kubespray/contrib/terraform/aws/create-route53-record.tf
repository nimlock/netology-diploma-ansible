data "aws_route53_zone" "selected" {
  name         = var.project_domain
  private_zone = false
}

resource "aws_route53_record" "wildcard" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "*.${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name                   = aws_elb.ingresses_http_elb.dns_name
    zone_id                = aws_elb.ingresses_http_elb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "k8s_api" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.k8s_api_subdomain}.${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name                   = module.aws-elb.aws_elb_api_fqdn
    zone_id                = module.aws-elb.aws_elb_api_zone_id
    evaluate_target_health = true
  }
}
