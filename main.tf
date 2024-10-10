data "google_project" "project" {}

data "google_client_config" "default" {}

resource "google_project_service" "serviceusage" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "serviceusage.googleapis.com"
}

resource "google_project_service" "compute" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "compute.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "container" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "container.googleapis.com"

  depends_on = [
    google_project_service.serviceusage,
    google_project_service.iam,
    google_project_service.storage_api,
    google_project_service.compute,
    google_project_service.containerregistry
  ]
}

resource "google_project_service" "containerregistry" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "containerregistry.googleapis.com"

  depends_on = [
    google_project_service.storage_api,
    google_project_service.serviceusage
  ]
}

resource "google_project_service" "storage_component" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "storage-component.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "storage_api" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "storage-api.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "iam" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "iam.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "logging" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "logging.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "monitoring" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "monitoring.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "dns" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "dns.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "network" {
  count   = var.gcp_services_enabled ? 1 : 0
  service = "servicenetworking.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}
