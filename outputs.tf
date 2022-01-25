output "project_id" {
  value = var.google_project_id
}

output "dns_name_servers" {
  value = var.dns_enabled ? google_dns_managed_zone.dns_zone.0.name_servers : []
}

# output "flux_deploy_key" {
#   value = var.flux_enabled ? tls_private_key.flux_secret.0.public_key_openssh : ""
#   sensitive   = true
# }

# GKE

output "cluster_name" {
  value = google_container_cluster.kube.name
}

output "gke_endpoint" {
  value     = google_container_cluster.kube.endpoint
  sensitive = true
}

output "gke_certificate" {
  value     = google_container_cluster.kube.master_auth.0.cluster_ca_certificate
  sensitive = true
}

output "gke_token" {
  value     = data.google_client_config.default.access_token
  sensitive = true
}
## kubernetes
output "flux_private_key_pem" {
  value     = var.flux_enabled ? tls_private_key.flux_secret.0.private_key_pem : ""
  sensitive = true
}

output "cert_manager_service_key" {
  value     = var.cert_manager_enabled ? base64decode(google_service_account_key.cert_manager_account_key.0.private_key) : ""
  sensitive = true
}

output "fluxv2_gcr_service_key" {
  value     = var.fluxv2_enabled ? base64decode(google_service_account_key.fluxv2_container_registry.0.private_key) : ""
  sensitive = true
}

output "fluxv2_private_key_pem" {
  value     = var.fluxv2_enabled ? tls_private_key.fluxv2_secret.0.private_key_pem : ""
  sensitive = true
}

output "fluxv2_public_key_pem" {
  value     = var.fluxv2_enabled ? tls_private_key.fluxv2_secret.0.public_key_pem : ""
  sensitive = true
}

output "sealed_secrets_cert_pem" {
  value     = var.sealed_secrets_enabled ? tls_self_signed_cert.sealed_secrets.0.cert_pem : ""
  sensitive = true
}

output "sealed_secrets_private_key" {
  value     = var.sealed_secrets_enabled ? tls_private_key.sealed_secrets.0.private_key_pem : ""
  sensitive = true
}
# vpc

output "google_compute_network_vpc_id" {
  value     = google_compute_network.vpc.id
  sensitive = true
}

output "google_compute_network_vpc_self_link" {
  value     = google_compute_network.vpc.self_link
  sensitive = true
}