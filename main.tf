data "google_project" "project" {}

resource "google_project_service" "compute" {
  project = var.google_project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  project = var.google_project_id
  service = "container.googleapis.com"

  depends_on = [
    "google_project_service.iam",
    "google_project_service.storage_api",
    "google_project_service.compute",
    "google_project_service.containerregistry"
    ]
}

resource "google_project_service" "containerregistry" {
  project = var.google_project_id
  service = "containerregistry.googleapis.com"

  depends_on = ["google_project_service.storage_api"]
}

resource "google_project_service" "storage_component" {
  project = var.google_project_id
  service = "storage-component.googleapis.com"
}

resource "google_project_service" "storage_api" {
  project = var.google_project_id
  service = "storage-api.googleapis.com"
}

resource "google_project_service" "iam" {
  project = var.google_project_id
  service = "iam.googleapis.com"
}

resource "google_project_service" "logging" {
  project = var.google_project_id
  service = "logging.googleapis.com"
}

resource "google_project_service" "monitoring" {
  project = var.google_project_id
  service = "monitoring.googleapis.com"
}

resource "google_project_service" "dns" {
  project = var.google_project_id
  service = "dns.googleapis.com"
}

resource "google_project_service" "network" {
  project = var.google_project_id
  service = "servicenetworking.googleapis.com"
}
