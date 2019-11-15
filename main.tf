data "google_project" "project" {}

data "google_client_config" "default" {}

resource "google_project_service" "serviceusage" {
  service = "serviceusage.googleapis.com"
}

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "container" {
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
  service = "containerregistry.googleapis.com"

  depends_on = [
    google_project_service.storage_api,
    google_project_service.serviceusage
    ]
}

resource "google_project_service" "storage_component" {
  service = "storage-component.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "storage_api" {
  service = "storage-api.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "iam" {
  service = "iam.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "logging" {
  service = "logging.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "monitoring" {
  service = "monitoring.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "dns" {
  service = "dns.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "network" {
  service = "servicenetworking.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}

resource "google_project_service" "sqladmin" {
  service = "sqladmin.googleapis.com"

  depends_on = [google_project_service.serviceusage]
}