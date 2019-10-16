resource "google_project_iam_binding" "editors" {
  project = var.project_id
  role    = "roles/editor"

  members = [
    "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com",
    "serviceAccount:${var.project_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${var.project_number}@containerregistry.iam.gserviceaccount.com"
  ]

  depends_on = ["google_project_service.iam"]
}

resource "google_project_iam_binding" "project_viewers" {
  project = var.project_id
  role    = "roles/viewer"

  members = [
    "serviceAccount:${var.project_number}-compute@developer.gserviceaccount.com",
    "serviceAccount:${var.project_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${var.project_number}@containerregistry.iam.gserviceaccount.com"
  ]

  depends_on = ["google_project_service.iam"]
}

resource "google_project_iam_member" "cloudsql_editors_member" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = var.project_editors

  depends_on = ["google_project_service.iam"]
}

resource "google_project_iam_member" "cloudsql_readers_member" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = var.project_readers

  depends_on = ["google_project_service.iam"]
}

resource "google_project_iam_binding" "container_admins" {
  project = var.project_id
  role    = "roles/container.admin"

  members = var.project_admins

  depends_on = ["google_project_service.iam"]
}

resource "google_project_iam_binding" "container_editors" {
  project = var.project_id
  role    = "roles/container.developer"

  members = ["${var.project_editors}"]

  depends_on = ["google_project_service.iam"]
}

resource "google_project_iam_binding" "container_readers" {
  project = var.project_id
  role    = "roles/container.viewer"

  members = ["${var.project_readers}"]

  depends_on = ["google_project_service.iam"]
}