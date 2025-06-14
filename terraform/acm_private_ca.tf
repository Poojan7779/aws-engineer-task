resource "aws_acmpca_certificate_authority" "private_ca" {
  type = "ROOT"

  certificate_authority_configuration {
    key_algorithm     = "RSA_2048"
    signing_algorithm = "SHA256WITHRSA"

    subject {
      common_name  = "My Private Root CA"
      organization = "MyOrg"
      country      = "US"
    }
  }

  permanent_deletion_time_in_days = 7
}

resource "aws_acmpca_certificate" "ca_cert" {
  certificate_authority_arn     = aws_acmpca_certificate_authority.private_ca.arn
  certificate_signing_request   = aws_acmpca_certificate_authority.private_ca.certificate_signing_request
  signing_algorithm             = "SHA256WITHRSA"

  validity {
    type  = "YEARS"
    value = 10
  }

  template_arn = "arn:aws:acm-pca:::template/RootCACertificate/V1"

  subject {
    common_name = "My Private Root CA"
    organization = "MyOrg"
    country      = "US"
  }
}

resource "aws_acmpca_certificate_authority_certificate" "signed_cert" {
  certificate_authority_arn = aws_acmpca_certificate_authority.private_ca.arn
  certificate               = aws_acmpca_certificate.ca_cert.certificate
}
