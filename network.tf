locals {
  public_ip_namespaces = {
    for namespace in var.k8s_namespaces :
    namespace.name => namespace
    if namespace.has_public_ip && namespace.name != "istio-ingress"
  }

  istio_ingress_ip = {
    for ingress_namespace in var.k8s_namespaces :
    ingress_namespace.name => ingress_namespace
    if ingress_namespace.has_public_ip && ingress_namespace == "istio-ingress"
  }
}

resource "google_compute_network" "vpc" {

  name                    = "vpc"
  auto_create_subnetworks = false

  depends_on = [google_project_service.compute]
}

resource "google_compute_subnetwork" "container_subnetwork" {
  name          = "container-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.vpc.self_link
}

resource "google_compute_global_address" "namespace_public_ip" {
  for_each = local.public_ip_namespaces

  name = "${each.key}-public-ip"

  depends_on = [google_project_service.compute]
}

resource "google_compute_address" "istio_gateway_ip" {
  count = var.anthos_enabled ? local.istio_ingress_ip ? 1 : 0 : 0

  name = "istio-ingress-public-ip"
  address_type = "EXTERNAL"
  region = var.google_region
}

resource "google_compute_global_address" "private_ip_network" {
  name          = "private-ip-network"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.self_link

  depends_on = [google_project_service.compute]
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_network.name]

  depends_on = [google_project_service.dns, google_project_service.network]
}
