locals {
  redis_namespaces = {
    for namespace in var.k8s_namespaces:
      namespace.name => namespace
    if var.redis_enabled && namespace.uses_redis
  }
}

resource "kubernetes_config_map" "redis_config" {
 for_each = local.redis_namespaces

  metadata {
    name = "redis"
    namespace = kubernetes_namespace.k8s_namespace[each.key].metadata.0.name
  }

  data = {
    host = google_redis_instance.cache.0.host
    port = google_redis_instance.cache.0.port
  }
}

resource "google_redis_instance" "cache" {
  count      = var.redis_enabled ? 1 : 0

  name           = "reddis-${var.environment_name}-${random_string.redis_name.0.result}"
  tier           = var.redis_tier
  memory_size_gb = var.redis_memory_size

  location_id             = "europe-west2-c"
  alternative_location_id = "europe-west2-b"

  authorized_network = google_compute_network.vpc.id
  connect_mode       = "PRIVATE_SERVICE_ACCESS"

  redis_version     = var.redis_version
  display_name      = "Redis-${var.environment_name}"

  depends_on = [ google_service_networking_connection.private_vpc_connection ]
}

resource "random_string" "redis_name" {
  count      = var.redis_enabled ? 1 : 0

  length = 4
  special = false
  upper = false
}

resource "google_project_service" "redis" {
  count      = var.redis_enabled ? 1 : 0

  service = "redis.googleapis.com"
}