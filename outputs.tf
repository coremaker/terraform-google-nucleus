output "project_id" {
  value       = var.google_project_id
  description = "Returns the project id."
}

output "project_number" {
  value       = data.google_project.project.number
  description = "Returns the project number."
}

# Neworking

output "dns_name_servers" {
  value       = var.dns_enabled ? google_dns_managed_zone.dns_zone[0].name_servers : []
  description = "List of the DNS servers."
}

output "regional_public_ips" {
  value       = zipmap([for r in local.regional_public_ip_namespaces : r.name], values(google_compute_address.namespace_regional_public_ip)[*].address)
  description = "Map with regional namespace-ip pairs"
}

output "global_public_ips" {
  value       = zipmap([for r in local.global_public_ip_namespaces : r.name], values(google_compute_global_address.namespace_public_ip)[*].address)
  description = "Map with global namespace-ip pairs"
}
# GKE

output "cluster_name" {
  value       = var.gke_enabled ? google_container_cluster.kube[0].name : ""
  description = "Cluster Name"
}

output "gke_cluster_id" {
  value       = var.gke_enabled ? google_container_cluster.kube[0].id : ""
  description = "Cluster ID"
}

output "gke_endpoint" {
  value       = var.gke_enabled ? google_container_cluster.kube[0].endpoint : ""
  sensitive   = true
  description = "The IP address of this cluster's Kubernetes master."
}

output "gke_certificate" {
  value       = var.gke_enabled ? google_container_cluster.kube[0].master_auth[0].cluster_ca_certificate : ""
  sensitive   = true
  description = "Base64 encoded public certificate that is the root of trust for the cluster."
}

output "gke_token" {
  value       = var.gke_enabled ? data.google_client_config.default.access_token : ""
  sensitive   = true
  description = "GKE cluster token."
}
## kubernetes
output "flux_private_key_pem" {
  value       = var.flux_enabled ? tls_private_key.flux_secret[0].private_key_pem : ""
  sensitive   = true
  description = "Private key to be used for github integration."
}

output "cert_manager_service_key" {
  value       = var.cert_manager_enabled ? base64decode(google_service_account_key.cert_manager_account_key[0].private_key) : ""
  sensitive   = true
  description = "Service account key with the right permissions for DNS used by cert-manager."
}

output "fluxv2_gcr_service_key" {
  value       = var.fluxv2_enabled ? base64decode(google_service_account_key.fluxv2_container_registry[0].private_key) : ""
  sensitive   = true
  description = "Service account key with the right permissions for GCR  used by fluxv2."
}

output "fluxv2_private_key_pem" {
  value       = var.fluxv2_enabled ? tls_private_key.fluxv2_secret[0].private_key_pem : ""
  sensitive   = true
  description = "Private key to be used for github integration."
}

output "fluxv2_public_key_pem" {
  value       = var.fluxv2_enabled ? tls_private_key.fluxv2_secret[0].public_key_pem : ""
  sensitive   = true
  description = "Public key to be used for github integration."
}

output "sealed_secrets_cert_pem" {
  value       = var.sealed_secrets_enabled ? tls_self_signed_cert.sealed_secrets[0].cert_pem : ""
  sensitive   = true
  description = "Self-signed cert to be used for the encryption/decryption of secrets."
}

output "sealed_secrets_private_key" {
  value       = var.sealed_secrets_enabled ? tls_private_key.sealed_secrets[0].private_key_pem : ""
  sensitive   = true
  description = "Private key used for the encryption of secrets."
}
# vpc

output "google_compute_network_vpc_id" {
  value       = google_compute_network.vpc.id
  sensitive   = true
  description = "an identifier for the VPC resource with format projects/{{project}}/global/networks/{{name}}"
}

output "google_compute_network_vpc_self_link" {
  value       = google_compute_network.vpc.self_link
  sensitive   = true
  description = "The URI of the created VPC."
}

# Subnets

output "google_compute_subnetwork_id" {
  value       = google_compute_subnetwork.container_subnetwork.id
  sensitive   = true
  description = "an identifier for the Subnet resource with format projects/{{project}}/regions/{{region}}/subnetworks/{{name}}"
}

output "google_compute_subnetwork_name" {
  value       = google_compute_subnetwork.container_subnetwork.name
  sensitive   = true
  description = "The name of the subnetwork"
}

output "google_compute_subnetwork_region" {
  value       = google_compute_subnetwork.container_subnetwork.region
  sensitive   = true
  description = "The GCP region for the subnetwork"
}
