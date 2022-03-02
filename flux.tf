resource "tls_private_key" "flux_secret" {
  count = var.flux_enabled ? 1 : 0

  algorithm = "ECDSA"
  ecdsa_curve  = "P384"
}