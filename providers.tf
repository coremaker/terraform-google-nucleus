terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.49.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "1.13.3"
    }

    helm = {
      source = "hashicorp/helm"
      version = "1.3.2"
    }

    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "0.7.0"
    }
  }
}

provider "google" {
  project = var.google_project_id
  region = var.google_region
}

provider "kubernetes" {
  load_config_file = false
  host = google_container_cluster.kube.endpoint
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.kube.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    load_config_file = false
    host = google_container_cluster.kube.endpoint
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.kube.master_auth.0.cluster_ca_certificate)
  }
}

provider "mongodbatlas" {}