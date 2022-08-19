resource "google_project_service" "mesh" {
  count   = var.anthos_enabled ? 1 : 0
  service = "mesh.googleapis.com"
}

resource "google_project_service" "anthos" {
  count   = var.anthos_enabled ? 1 : 0
  service = "anthos.googleapis.com"
}

resource "google_gke_hub_feature" "mesh" {
  count = var.anthos_enabled ? 1 : 0

  provider = google-beta

  name     = "servicemesh"
  project  = var.google_project_id
  location = "global"

  depends_on = [google_project_service.mesh, google_project_service.anthos]
}

resource "google_gke_hub_membership" "membership" {
  count = var.anthos_enabled ? 1 : 0

  provider = google-beta

  project       = var.google_project_id
  membership_id = var.gke_cluster_name
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${google_container_cluster.kube.id}"
    }
  }

  authority {
    issuer = "https://container.googleapis.com/v1/${google_container_cluster.kube.id}"
  }

  depends_on = [google_gke_hub_feature.mesh]
}