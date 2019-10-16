provider "google" {
}

provider "kubernetes" {
  host = "${google_container_cluster.kube.endpoint}"

  cluster_ca_certificate = "${base64decode(google_container_cluster.kube.master_auth.0.cluster_ca_certificate)}"
}

provider "helm" {
  kubernetes {
    host = "${google_container_cluster.kube.endpoint}"

    cluster_ca_certificate = "${base64decode(google_container_cluster.kube.master_auth.0.cluster_ca_certificate)}"
  }

  tiller_image = "gcr.io/kubernetes-helm/tiller:${var.tiller_version}"
  service_account = "${kubernetes_service_account.tiller.metadata.0.name}"
}
