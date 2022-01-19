module "kubernetes" {
  source = "github.com/coremaker/terraform-kubernetes.git?ref=first-commits"
  count = var.kubernetes_enabled ? 1 : 0

  k8s_namespaces = var.k8s_namespaces
  google_project_id = var.google_project_id

  cert_manager_enabled = var.cert_manager_enabled
  cert_manager_service_key = var.cert_manager_enabled ? base64decode(google_service_account_key.cert_manager_account_key.0.private_key) : ""

  fluxv2_enabled = var.fluxv2_enabled
  fluxv2_gcr_service_key = var.fluxv2_enabled ? base64decode(google_service_account_key.fluxv2_container_registry.0.private_key) : ""
  fluxv2_private_key_pem = var.fluxv2_enabled ? tls_private_key.fluxv2_secret.0.private_key_pem : ""
  fluxv2_public_key_pem = var.fluxv2_enabled ? tls_private_key.fluxv2_secret.0.public_key_pem : ""

  flux_enabled = var.flux_enabled
  flux_private_key_pem = var.flux_enabled ? tls_private_key.flux_secret.0.private_key_pem : ""

  sealed_secrets_enabled = var.sealed_secrets_enabled
  sealed_secrets_cert_pem = var.sealed_secrets_enabled ? tls_self_signed_cert.sealed_secrets.0.cert_pem : ""
  sealed_secrets_private_key = var.sealed_secrets_enabled ? tls_private_key.sealed_secrets.0.private_key_pem : ""
}
