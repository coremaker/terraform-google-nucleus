locals {
  mongodb_atlas_namespaces = {
    for namespace in var.k8s_namespaces:
      namespace.name => namespace
    if var.mongodb_atlas_enabled && namespace.uses_mongodb_atlas
  }

  mongodb_atlas_is_tenant = var.mongodb_atlas_instance_size_name == "M2" || var.mongodb_atlas_instance_size_name == "M5"
}

resource "kubernetes_secret" "mongodb_atlas_root_user_secret" {
  for_each = local.mongodb_atlas_namespaces

  metadata {
    name = "mongodb-atlas-root"
    namespace = kubernetes_namespace.k8s_namespace[each.key].metadata.0.name
  }

  data = {
    username = mongodbatlas_database_user.mongodb_atlas_user.0.username
    password = mongodbatlas_database_user.mongodb_atlas_user.0.password
  }
}

resource "mongodbatlas_database_user" "mongodb_atlas_user" {
  count      = var.mongodb_atlas_enabled ? 1 : 0

  username = "root"
  password = random_password.mongodb_atlas_root_user_pass.0.result
  project_id = mongodbatlas_project.mongodb_atlas.0.id
  auth_database_name  = "admin"

  roles {
    role_name = "readWrite"
    database_name = "admin"
  }
}

resource "random_password" "mongodb_atlas_root_user_pass" {
  count      = var.mongodb_atlas_enabled ? 1 : 0

  length = 24
  special = true
}

resource "mongodbatlas_cluster" "mongodb_atlas_tenant" {
  count      = var.mongodb_atlas_enabled && local.mongodb_atlas_is_tenant ? 1 : 0

  project_id   = mongodbatlas_project.mongodb_atlas.0.id
  name         = "mongodb-${random_string.mongodb_atlas_random_name.0.result}"
  auto_scaling_disk_gb_enabled = false
  mongo_db_major_version       = "4.0"
  //Provider Settings "block"
  provider_name               = "TENANT"
  backing_provider_name       = "GCP"
  provider_instance_size_name = var.mongodb_atlas_instance_size_name
  disk_size_gb                = var.mongodb_atlas_disk_size
  provider_region_name        = var.mongodb_atlas_region
}

resource "mongodbatlas_cluster" "mongodb_atlas" {
  count      = var.mongodb_atlas_enabled && !local.mongodb_atlas_is_tenant ? 1 : 0

  project_id   = mongodbatlas_project.mongodb_atlas.0.id
  name         = "mongodb-${random_string.mongodb_atlas_random_name.0.result}"
  auto_scaling_disk_gb_enabled = false
  mongo_db_major_version       = "4.0"
  //Provider Settings "block"
  provider_name               = "GCP"
  provider_instance_size_name = var.mongodb_atlas_instance_size_name
  disk_size_gb                = var.mongodb_atlas_disk_size
  provider_region_name        = var.mongodb_atlas_region
}

resource "mongodbatlas_project" "mongodb_atlas" {
  count      = var.mongodb_atlas_enabled ? 1 : 0

  name   = var.environment_name
  org_id = var.mongodb_atlas_org_id
}

resource "random_string" "mongodb_atlas_random_name" {
  count      = var.mongodb_atlas_enabled ? 1 : 0

  length = 4
  special = false
  upper = false
}