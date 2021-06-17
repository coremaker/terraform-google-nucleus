output "project_id" {
  value = var.google_project_id
}

output "dns_name_servers" {
  value = var.dns_enabled ? google_dns_managed_zone.dns_zone.0.name_servers : []
}

output "flux_deploy_key" {
  value = var.flux_enabled ? tls_private_key.flux_secret.0.public_key_openssh : ""
  sensitive   = true
}

output "cluster_name" {
  value = google_container_cluster.kube.name
}

output "google_compute_network_vpc_id" {
  value = google_compute_network.vpc.id
  sensitive = true
}

output "google_compute_network_vpc_self_link" {
  value = google_compute_network.vpc.self_link
  sensitive = true
}