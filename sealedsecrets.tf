resource "tls_self_signed_cert" "sealed_secrets" {
  count = var.sealed_secrets_enabled ? 1 : 0

  private_key_pem = tls_private_key.sealed_secrets[0].private_key_pem

  validity_period_hours = 210240
  early_renewal_hours   = 48

  allowed_uses = [
    "encipher_only"
  ]

  dns_names = ["localhost"]

  subject {
    common_name  = "localhost"
    organization = "Coremaker"
  }
}

resource "tls_private_key" "sealed_secrets" {
  count = var.sealed_secrets_enabled ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = "2048"
}
