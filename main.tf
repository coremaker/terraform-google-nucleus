data "google_project" "project" {}

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  service = "container.googleapis.com"

  depends_on = [
    "google_project_service.iam",
    "google_project_service.storage_api",
    "google_project_service.compute",
    "google_project_service.containerregistry"
    ]
}

resource "google_project_service" "containerregistry" {
  service = "containerregistry.googleapis.com"

  depends_on = ["google_project_service.storage_api"]
}

resource "google_project_service" "storage_component" {
  service = "storage-component.googleapis.com"
}

resource "google_project_service" "storage_api" {
  service = "storage-api.googleapis.com"
}

resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
}

resource "google_project_service" "logging" {
  service = "logging.googleapis.com"
}

resource "google_project_service" "monitoring" {
  service = "monitoring.googleapis.com"
}

resource "google_project_service" "dns" {
  service = "dns.googleapis.com"
}

resource "google_project_service" "network" {
  service = "servicenetworking.googleapis.com"
}
