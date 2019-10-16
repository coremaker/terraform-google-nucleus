locals {
  postgres_namespaces = {
    for namespace in var.k8s_namespaces:
      namespace.name => namespace
    if var.postgres_enabled && namespace.uses_postgres
  }
}

resource "kubernetes_secret" "postgres_root_user_secret" {
 for_each = local.postgres_namespaces

  metadata {
    name = "postgres-root"
    namespace = "${kubernetes_namespace.k8s_namespace[each.key].metadata.0.name}"
  }

  data = {
    username = "${google_sql_user.postgres_root_user.0.name}"
    password = "${google_sql_user.postgres_root_user.0.password}"
  }
}

resource "google_sql_user" "postgres_root_user" {
  count      = "${var.postgres_enabled ? 1 : 0}"

  instance = "${google_sql_database_instance.postgres_db.0.name}"

  name     = "root"
  password = "${random_password.postgres_root_user_pass.0.result}"
}

resource "random_password" "postgres_root_user_pass" {
  count      = "${var.postgres_enabled ? 1 : 0}"

  length = 24
  special = true
}

resource "kubernetes_config_map" "postgres_config" {
 for_each = local.postgres_namespaces

  metadata {
    name = "postgres"
    namespace = "${kubernetes_namespace.k8s_namespace[each.key].metadata.0.name}"
  }

  data = {
    privateIp = "${google_sql_database_instance.postgres_db.0.private_ip_address}"
    publicIp = "${google_sql_database_instance.postgres_db.0.public_ip_address}"

    port = "5432"
    connectionName = "${google_sql_database_instance.postgres_db.0.connection_name}"
  }
}

resource "google_sql_database_instance" "postgres_db" {
  count      = "${var.postgres_enabled ? 1 : 0}"

  name             = "${var.google_project_id}-postgres-${random_string.postgres_db_name.0.result}"
  database_version = "${var.postgres_database_version}"

  settings {
    tier = "${var.postgres_machine_type}"
    disk_size = "10"

    ip_configuration {
      ipv4_enabled = "true"
      private_network = "${google_compute_network.vpc.self_link}"
    }

    backup_configuration  {
      enabled = true
      start_time = "02:39"
    }
  }

  lifecycle {
    ignore_changes = ["project", "region"]
  }

  timeouts {
    create = "20m"
  }

 depends_on = ["google_service_networking_connection.private_vpc_connection"]
}

resource "random_string" "postgres_db_name" {
  count      = "${var.postgres_enabled ? 1 : 0}"

  length = 4
  special = false
  upper = false
}