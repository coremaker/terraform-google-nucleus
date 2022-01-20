locals {
  gke_node_pools = {
    for node in var.gke_node_pools:
    node.name => node
  }
}

resource "google_container_cluster" "kube" {
  name     = var.gke_cluster_name
  location = var.google_region

  release_channel {
    channel = var.gke_release_channel
  }

  node_locations = ["europe-west2-a"]
  network = google_compute_network.vpc.self_link
  subnetwork = google_compute_subnetwork.container_subnetwork.name

  remove_default_node_pool = true
  initial_node_count = 1

  enable_shielded_nodes = var.gke_enable_shielded_nodes

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.0.0.0/16"
    services_ipv4_cidr_block = "10.1.0.0/16"
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  lifecycle {
    ignore_changes = [node_pool, master_auth]
  }

  depends_on = [
    google_project_service.container,
    google_project_service.compute,
    google_project_service.storage_api,
    google_project_service.storage_component,
    google_project_service.monitoring,
    google_project_service.logging
  ]
}

resource "google_container_node_pool" "kube_nodes" {
  for_each = local.gke_node_pools

  location   = var.google_region

  name       = each.key
  cluster    = google_container_cluster.kube.name

  autoscaling {
    min_node_count = each.value.min_node_count
    max_node_count = each.value.max_node_count
  }

  management {
    auto_repair = var.gke_node_auto_repair
    auto_upgrade = var.gke_node_auto_upgrade
  }

  node_config {
    machine_type = each.value.machine_type
    image_type = each.value.image_type

    dynamic "taint" {
      for_each = each.value.taints

      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }

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

  depends_on = [google_container_cluster.kube]
}