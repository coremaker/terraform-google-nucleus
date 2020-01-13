locals {
  mongodb_namespaces = {
    for namespace in var.k8s_namespaces:
      namespace.name => namespace
    if var.mongodb_enabled && namespace.uses_mongodb
  }
}

resource "kubernetes_secret" "mongodb_root_user_secret" {
  for_each = local.mongodb_namespaces

  metadata {
    name = "mongodb-root"
    namespace = kubernetes_namespace.k8s_namespace[each.key].metadata.0.name
  }

  data = {
    username = mongodbatlas_database_user.mongodb_user.0.username
    password = mongodbatlas_database_user.mongodb_user.0.password
  }
}

resource "mongodbatlas_database_user" "mongodb_user" {
  count      = var.mongodb_enabled ? 1 : 0

  username = "root"
  password = random_password.mongodb_root_user_pass.0.result
  project_id = mongodbatlas_project.mongodb.0.id
  database_name  = "admin"

  roles {
    role_name = "readWrite"
    database_name = "admin"
  }
}

resource "random_password" "mongodb_root_user_pass" {
  count      = var.mongodb_enabled ? 1 : 0

  length = 24
  special = true
}

resource "mongodbatlas_cluster" "mongodb" {
  count      = var.mongodb_enabled ? 1 : 0

  project_id   = mongodbatlas_project.mongodb.0.id
  name         = "mongodb-${random_string.mongodb_random_name.0.result}"
  num_shards   = 1
  replication_factor           = 3
  backup_enabled               = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.0"
  //Provider Settings "block"
  provider_name               = "GCP"
  provider_instance_size_name = var.mongodbatlas_instance_size_name
  disk_size_gb                = var.mongodbatlas_disk_size
  provider_region_name        = var.mongodbatlas_region
}

resource "mongodbatlas_project" "mongodb" {
  count      = var.mongodb_enabled ? 1 : 0

  name   = "mongodb-${random_string.mongodb_random_name.0.result}"
  org_id = var.mongodbatlas_org_id
}

resource "random_string" "mongodb_random_name" {
  count      = var.mongodb_enabled ? 1 : 0

  length = 4
  special = false
  upper = false
}