resource "google_project_iam_member" "cert_manager_account_dns_admin" {
  count      = var.cert_manager_enabled ? 1 : 0

  role    = "roles/dns.admin"
  member  = "serviceAccount:${google_service_account.cert_manager_account.0.email}"
}

resource "helm_release" "cert_manager_lentsencrypt" {
  count      = var.cert_manager_enabled ? 1 : 0

  name       = "cert-managers-letsencrypt"
  chart      = format("%s/helm-charts/cert-manager-letsencrypt", path.module)

  set {
    name = "clouddns.projectId"
    value = var.google_project_id
  }

  depends_on = [kubernetes_cluster_role_binding.tiller_cluster_admin, kubernetes_namespace.cert_manager, helm_release.cert_manager]
}

resource "helm_release" "cert_manager" {
  count      = var.cert_manager_enabled ? 1 : 0

  chart      = "cert-manager"
  repository = "https://charts.jetstack.io"

  name       = "cert-manager"
  version    = var.cert_manager_helm_version
  namespace  = kubernetes_namespace.cert_manager.0.metadata.0.name

  set {
    name = "webhook.enabled"
    value = "false"
  }

  set {
    name = "cainjector.enabled"
    value = "false"
  }

  timeout    = "60"

  depends_on = [kubernetes_cluster_role_binding.tiller_cluster_admin, kubernetes_namespace.cert_manager, kubernetes_secret.cert_manager_service_key, helm_release.cert_manager_crds]
}

resource "kubernetes_secret" "cert_manager_service_key" {
  count      = var.cert_manager_enabled ? 1 : 0

  metadata {
    name = "cert-manager-secrets"
    namespace = kubernetes_namespace.cert_manager.0.metadata.0.name
  }

  data = {
    "cert-manager-service.private-key.json" = base64decode(google_service_account_key.cert_manager_account_key.0.private_key)
  }

  depends_on = [kubernetes_namespace.cert_manager]
}

resource "google_service_account_key" "cert_manager_account_key" {
  count      = var.cert_manager_enabled ? 1 : 0

  service_account_id = google_service_account.cert_manager_account.0.name
  public_key_type    = "TYPE_X509_PEM_FILE"
  private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"
}

resource "google_service_account" "cert_manager_account" {
  count      = var.cert_manager_enabled ? 1 : 0

  account_id   = "${var.k8s_cluster_name}-cert-manager"
  display_name = "Cert manager service accountfor the ${var.k8s_cluster_name} kube cluster"

  depends_on = [google_project_service.iam]
}

resource "helm_release" "cert_manager_crds" {
  count      = var.cert_manager_enabled ? 1 : 0

  name       = "cert-managers-crds"
  chart      = format("%s/helm-charts/cert-manager-crds", path.module)

  depends_on = [kubernetes_cluster_role_binding.tiller_cluster_admin, kubernetes_namespace.cert_manager]
}

resource "kubernetes_namespace" "cert_manager" {
  count      = var.cert_manager_enabled ? 1 : 0

  metadata {
    name = "cert-manager"
  }
}