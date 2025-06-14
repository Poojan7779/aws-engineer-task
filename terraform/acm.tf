resource "aws_acm_certificate" "private" {
  domain_name               = "test.local"
  validation_method         = "DNS"
  certificate_authority_arn = aws_acmpca_certificate_authority.private_ca.arn

  options {
    certificate_transparency_logging_preference = "DISABLED"
  }

  tags = {
    Name = "PrivateCert"
  }
}
