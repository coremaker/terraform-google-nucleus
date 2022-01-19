module "kubernetes" {
  source = "github.com/coremaker/terraform-kubernetes.git?ref=first-commits"
  count = var.kubernetes_enabled ? 1 : 0

  k8s_namespaces = local.k8s_namespaces
  cert_manager_enabled = var.cert_manager_enabled
#   cert_manager_service_key = base64decode(module.nucleus.k8s_cert_manager_account_key)
  cert_manager_service_key = base64decode(google_service_account_key.cert_manager_account_key.0.private_key)
}
