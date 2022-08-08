resource "google_service_account" "cert_manager_account" {
  count = var.cert_manager_enabled ? 1 : 0

  account_id   = "${var.gke_cluster_name}-cert-manager"
  display_name = "Cert manager service accountfor the ${var.gke_cluster_name} kube cluster"

  depends_on = [google_project_service.iam]
}

resource "google_service_account_key" "cert_manager_account_key" {
  count = var.cert_manager_enabled ? 1 : 0

  service_account_id = google_service_account.cert_manager_account.0.name
  public_key_type    = "TYPE_X509_PEM_FILE"
  private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"
}

resource "google_project_iam_member" "cert_manager_account_dns_admin" {
  project = var.google_project_id
  count   = var.cert_manager_enabled ? 1 : 0

  role   = "roles/dns.admin"
  member = "serviceAccount:${google_service_account.cert_manager_account.0.email}"
}
