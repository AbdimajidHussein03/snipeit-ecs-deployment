resource "aws_acm_certificate" "main" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name    = var.domain_name
    Project = var.project_name
    Managed = "Terraform"
  }
}

resource "aws_route53_record" "certificate_validation" {
  name    = tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_type
  zone_id = var.route53_zone_id
  records = [
    tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_value
  ]
  ttl = 60
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [aws_route53_record.certificate_validation.fqdn]
}