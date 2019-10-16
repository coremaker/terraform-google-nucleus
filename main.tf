/*
resource "google_project" "project" {
  name            = "${var.project_id}"
  project_id      = "${var.project_id}"
  billing_account = "${var.billing_account}"
  org_id          = "${var.org_id}"
  skip_delete     = true
}
*/

# locals {
#   services = toset([
#     # "bigquery-json.googleapis.com",
#     # "bigquerystorage.googleapis.com",
#     # "compute.googleapis.com",
#     # "container.googleapis.com",
#     # "storage-component.googleapis.com",
#     # "storage-api.googleapis.com",
#     # "iam.googleapis.com",
#     # "oslogin.googleapis.com",
#     # "sqladmin.googleapis.com",
#     # "containerregistry.googleapis.com",
#     # "pubsub.googleapis.com",
#     # "logging.googleapis.com",
#     # "monitoring.googleapis.com",
#     # "dns.googleapis.com",
#     # "places-backend.googleapis.com",
#     # "maps-backend.googleapis.com",
#     # "iamcredentials.googleapis.com",
#     # "cloudkms.googleapis.com",
#     # "servicenetworking.googleapis.com"
#   ])
# }

resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "container" {
  project = var.project_id
  service = "container.googleapis.com"

  depends_on = [
    "google_project_service.iam",
    "google_project_service.storage_api",
    "google_project_service.compute",
    "google_project_service.containerregistry"
    ]
}

resource "google_project_service" "containerregistry" {
  project = var.project_id
  service = "containerregistry.googleapis.com"

  depends_on = ["google_project_service.storage_api"]
}

resource "google_project_service" "storage_component" {
  project = var.project_id
  service = "storage-component.googleapis.com"
}

resource "google_project_service" "storage_api" {
  project = var.project_id
  service = "storage-api.googleapis.com"
}

resource "google_project_service" "iam" {
  project = var.project_id
  service = "iam.googleapis.com"
}

resource "google_project_service" "logging" {
  project = var.project_id
  service = "logging.googleapis.com"
}

resource "google_project_service" "monitoring" {
  project = var.project_id
  service = "monitoring.googleapis.com"
}

resource "google_project_service" "dns" {
  project = var.project_id
  service = "dns.googleapis.com"
}

resource "google_project_service" "network" {
  project = var.project_id
  service = "servicenetworking.googleapis.com"
}
