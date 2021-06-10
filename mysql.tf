locals {
  mysql_namespaces = {
    for namespace in var.k8s_namespaces:
      namespace.name => namespace
    if var.mysql_enabled && namespace.uses_mysql
  }
}

resource "kubernetes_secret" "mysql_root_user_secret" {
  for_each = local.mysql_namespaces

  metadata {
    name = "mysql-root"
    namespace = kubernetes_namespace.k8s_namespace[each.key].metadata.0.name
  }

  data = {
    username = google_sql_user.mysql_root_user.0.name
    password = google_sql_user.mysql_root_user.0.password
  }
}

resource "google_sql_user" "mysql_root_user" {
  count      = var.mysql_enabled ? 1 : 0

  instance = google_sql_database_instance.mysql_db.0.name

  name     = "root"
  password = random_password.mysql_root_user_pass.0.result

  depends_on = [google_sql_database_instance.mysql_db]
}

resource "random_password" "mysql_root_user_pass" {
  count      = var.mysql_enabled ? 1 : 0

  length = 24
  special = true
}

resource "kubernetes_config_map" "mysql_config" {
 for_each = local.mysql_namespaces

  metadata {
    name = "mysql"
    namespace = kubernetes_namespace.k8s_namespace[each.key].metadata.0.name
  }

  data = {
    privateIp = google_sql_database_instance.mysql_db.0.private_ip_address
    publicIp = google_sql_database_instance.mysql_db.0.public_ip_address

    port = "3306"
    connectionName = google_sql_database_instance.mysql_db.0.connection_name
  }
}

resource "google_sql_database_instance" "mysql_db" {
  count      = var.mysql_enabled ? 1 : 0

  name             = "${var.google_project_id}-mysql-${random_string.mysql_db_name.0.result}"
  database_version = var.mysql_database_version
  deletion_protection = false

  settings {
    tier = var.mysql_machine_type
    disk_size = var.mysql_disk_size

    ip_configuration {
      ipv4_enabled = "true"
      private_network = google_compute_network.vpc.self_link
    }

    backup_configuration  {
      enabled = true
      start_time = "02:39"
    }
  }

  lifecycle {
    ignore_changes = [project, region]
  }

  timeouts {
    create = "20m"
  }

  depends_on = [
    google_project_service.sqladmin,
    google_service_networking_connection.private_vpc_connection
  ]
}

resource "random_string" "mysql_db_name" {
  count      = var.mysql_enabled ? 1 : 0

  length = 4
  special = false
  upper = false
}