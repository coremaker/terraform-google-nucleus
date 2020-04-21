provider "google" {
  project = var.google_project_id
  region = var.google_region
}

provider "kubernetes" {
  version = "v1.9.0"

  host = google_container_cluster.kube.endpoint
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.kube.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  version = "v1.1.1"

  kubernetes {
    host = google_container_cluster.kube.endpoint
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.kube.master_auth.0.cluster_ca_certificate)
  }
}

provider "mongodbatlas" {}