resource "google_project_iam_binding" "editors" {
  role    = "roles/editor"

  members = concat([
    "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com",
    "serviceAccount:${data.google_project.project.number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.project.number}@containerregistry.iam.gserviceaccount.com"
  ], tolist(var.project_editors))

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_binding" "project_viewers" {
  role    = "roles/viewer"

  members = concat([
    "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com",
    "serviceAccount:${data.google_project.project.number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.project.number}@containerregistry.iam.gserviceaccount.com"
  ], tolist(var.project_viewers))

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_member" "cloudsql_editors_member" {
  for_each = var.project_editors

  role    = "roles/cloudsql.client"
  member  = each.key

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_member" "cloudsql_readers_member" {
  for_each = var.project_viewers

  role    = "roles/cloudsql.client"

  member  = each.key

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_binding" "container_admins" {
  role    = "roles/container.admin"

  members = var.project_admins

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_binding" "container_editors" {
  role    = "roles/container.developer"

  members = var.project_editors

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_binding" "container_readers" {
  role    = "roles/container.viewer"

  members = var.project_viewers

  depends_on = [google_project_service.iam]
}