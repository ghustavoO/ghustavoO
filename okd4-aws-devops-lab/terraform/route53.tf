# Elastic IP

resource "aws_eip" "api" {
  domain = "vpc"
}

# Hosted Zone

resource "aws_route53_zone" "main" {
  name = var.domain_name
}

# api.devops-labs.io

resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_eip.api.public_ip]
}

# api-int.devops-labs.io

resource "aws_route53_record" "api_int" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api-int.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_eip.api.public_ip]
}

# *.apps.devops-labs.io

resource "aws_route53_record" "apps" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "*.apps.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_eip.api.public_ip]
}