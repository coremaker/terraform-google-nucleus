output "project_id" {
  value = "${var.project_id}"
}

output "dns_name_servers" {
  value = "${google_dns_managed_zone.dns_zone.0.name_servers}"
}

output "postgres_instance_name" {
  value = "${google_sql_database_instance.postgres_db.0.name}"
}