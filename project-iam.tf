resource "google_project_iam_binding" "editors" {
  project = var.google_project_id
  role    = "roles/editor"

  members = concat([
    "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com",
    "serviceAccount:${data.google_project.project.number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.project.number}@containerregistry.iam.gserviceaccount.com"
  ], tolist(var.project_editors))

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_binding" "project_viewers" {
  project = var.google_project_id
  role    = "roles/viewer"

  members = concat([
    "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com",
    "serviceAccount:${data.google_project.project.number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${data.google_project.project.number}@containerregistry.iam.gserviceaccount.com"
  ], tolist(var.project_viewers))

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_member" "cloudsql_editors_member" {
  project  = var.google_project_id
  for_each = var.project_editors

  role   = "roles/cloudsql.client"
  member = each.key

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_member" "cloudsql_readers_member" {
  project  = var.google_project_id
  for_each = var.project_viewers

  role = "roles/cloudsql.client"

  member = each.key

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_member" "container_admins" {
  project  = var.google_project_id
  for_each = var.project_admins

  role = "roles/container.admin"

  member = each.key

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_binding" "container_editors" {
  project = var.google_project_id
  role    = "roles/container.developer"

  members = var.project_editors

  depends_on = [google_project_service.iam]
}

resource "google_project_iam_binding" "container_readers" {
  project = var.google_project_id
  role    = "roles/container.viewer"

  members = var.project_viewers

  depends_on = [google_project_service.iam]
}

resource "google_billing_account_iam_binding" "billing_viewers" {
  billing_account_id = var.google_billing_account_id
  role               = "roles/billing.viewer"

  members = var.project_billing_viewers

  depends_on = [google_project_service.iam]
}