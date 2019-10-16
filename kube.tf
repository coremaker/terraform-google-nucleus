locals {
  k8s_namespaces = {
    for namespace in var.k8s_namespaces:
    namespace.name => namespace
  }
}

resource "kubernetes_namespace" "k8s_namespace" {
  for_each = local.k8s_namespaces

  metadata {
    name = each.key
  }
  depends_on = ["google_container_cluster.kube", "google_container_node_pool.kube_nodes"]
}

resource "google_container_cluster" "kube" {
  project  = "${var.project_id}"
  name     = "${var.k8s_cluster_name}"
  location = "${var.region}"

  node_locations = ["europe-west2-a"]
  network = "${google_compute_network.vpc.self_link}"

  remove_default_node_pool = true
  initial_node_count = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  addons_config {
    kubernetes_dashboard {
      disabled = true
    }
  }

  ip_allocation_policy {
    use_ip_aliases = true
  }

  lifecycle {
    ignore_changes = ["node_pool", "master_auth"]
  }

  depends_on = [
    "google_project_service.container",
    "google_project_service.compute",
    "google_project_service.storage_api",
    "google_project_service.storage_component",
    "google_project_service.monitoring",
    "google_project_service.logging"]
}

resource "google_container_node_pool" "kube_nodes" {
  project = "${var.project_id}"
  location   = "${var.region}"

  name       = "${google_container_cluster.kube.name}-nodes"
  cluster    = "${google_container_cluster.kube.name}"

  node_count = "${var.k8s_node_count}"

  node_config {
    machine_type = "${var.k8s_node_type}"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "kubernetes_storage_class" "ssd" {
  metadata {
    name = "ssd"
  }
  storage_provisioner = "kubernetes.io/gce-pd"
  parameters = {
    type = "pd-ssd"
  }
}