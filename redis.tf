resource "google_redis_instance" "cache" {
  count      = var.redis_enabled ? 1 : 0

  name           = "reddis-${var.environment_name}-${random_string.reddis_name.0.result}"
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

resource "random_string" "reddis_name" {
  count      = var.redis_enabled ? 1 : 0

  length = 4
  special = false
  upper = false
}