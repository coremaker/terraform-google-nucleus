resource "tls_private_key" "flux_secret" {
  count      = var.flux_enabled ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = "2048"
}
