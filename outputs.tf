output "project_id" {
  value = var.google_project_id
}

output "dns_name_servers" {
  value = var.dns_enabled ? google_dns_managed_zone.dns_zone.0.name_servers : []
}

output "postgres_instance_name" {
  value = var.postgres_enabled ? google_sql_database_instance.postgres_db.0.name : ""
}

output "postgres_connection_name" {
  value = var.postgres_enabled ? google_sql_database_instance.postgres_db.0.connection_name : ""
}

output "postgres_private_ip_address" {
  value = var.postgres_enabled ? google_sql_database_instance.postgres_db.0.private_ip_address : ""
}

output "mysql_instance_name" {
  value = var.mysql_enabled ? google_sql_database_instance.mysql_db.0.name : ""
}

output "mysql_connection_name" {
  value = var.mysql_enabled ? google_sql_database_instance.mysql_db.0.connection_name : ""
}

output "mysql_private_ip_address" {
  value = var.mysql_enabled ? google_sql_database_instance.mysql_db.0.private_ip_address : ""
}

output "flux_deploy_key" {
  value = var.flux_enabled ? tls_private_key.flux_secret.0.public_key_openssh : ""
}

output "cluster_name" {
  value = google_container_cluster.kube.name
}