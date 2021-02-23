terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.57.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.0.2"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.0.2"
    }

    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "0.8.2"
    }
  }
}

provider "google" {
  project = var.google_project_id
  region = var.google_region
}

provider "kubernetes" {
  host = google_container_cluster.kube.endpoint
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.kube.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host = google_container_cluster.kube.endpoint
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.kube.master_auth.0.cluster_ca_certificate)
  }
}

provider "mongodbatlas" {}