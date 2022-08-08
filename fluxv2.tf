resource "google_service_account" "fluxv2" {
  count = var.fluxv2_enabled ? 1 : 0

  account_id   = "fluxv2"
  display_name = "fluxv2 service account"
}

resource "google_service_account_key" "fluxv2_container_registry" {
  count = var.fluxv2_enabled ? 1 : 0

  service_account_id = google_service_account.fluxv2.0.id
  public_key_type    = "TYPE_X509_PEM_FILE"
  private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"
}

resource "tls_private_key" "fluxv2_secret" {
  count = var.fluxv2_enabled ? 1 : 0

  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}
