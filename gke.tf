locals {
  gke_node_pools = {
    for node in var.gke_node_pools :
    node.name => node
  }

  location       = var.gke_regional ? var.google_region : var.gke_node_locations[0]
  node_locations = var.gke_regional ? var.gke_node_locations : slice(var.gke_node_locations, 1, length(var.gke_node_locations))
}

resource "google_container_cluster" "kube" {
  count           = var.gke_enabled ? 1 : 0
  name            = var.gke_cluster_name
  location        = local.location
  resource_labels = var.gke_cluster_resource_labels

  release_channel {
    channel = var.gke_release_channel
  }

  node_locations = local.node_locations
  network        = google_compute_network.vpc.self_link
  subnetwork     = google_compute_subnetwork.container_subnetwork.name

  remove_default_node_pool = true
  initial_node_count       = 1

  enable_shielded_nodes = var.gke_enable_shielded_nodes

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.0.0.0/16"
    services_ipv4_cidr_block = "10.1.0.0/16"
  }

  dynamic "workload_identity_config" {
    for_each = var.k8s_workload_identity != "" ? [1] : []
    content {
      workload_pool = var.k8s_workload_identity
    }
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
  for_each = var.gke_enabled ? local.gke_node_pools : {}

  location       = local.location
  node_locations = each.value.node_locations != null ? each.value.node_locations : null
  node_count     = each.value.autoscaling != true ? each.value.node_count : null

  name    = each.key
  cluster = google_container_cluster.kube[0].name

  dynamic "autoscaling" {
    for_each = each.value.autoscaling == true ? [1] : []
    content {
      min_node_count = each.value.min_node_count
      max_node_count = each.value.max_node_count
    }
  }

  management {
    auto_repair  = var.gke_node_auto_repair
    auto_upgrade = var.gke_node_auto_upgrade
  }

  node_config {
    machine_type = each.value.machine_type
    image_type   = each.value.image_type
    disk_size_gb = each.value.disk_size_gb
    disk_type    = each.value.disk_type
    spot         = each.value.spot

    dynamic "taint" {
      for_each = each.value.taints != null ? each.value.taints : []

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
      "https://www.googleapis.com/auth/trace.append",
    ]
  }

  depends_on = [google_container_cluster.kube]
}
