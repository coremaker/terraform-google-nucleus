locals {
  dns_record_pairs = flatten([
    for namespace in var.k8s_namespaces: [
      for dns_record in namespace.dns_records: {
        dns_record = dns_record
        namespace  = namespace.name
        regional_ip = namespace.regional_ip
      }
    ]
    if namespace.has_public_ip
  ])

  dns_records = {
    for dns_record in local.dns_record_pairs :
    dns_record.dns_record => dns_record
  }
}

resource "google_dns_record_set" "dns_record" {
  for_each = local.dns_records

  name         = "${each.key}."
  type         = "A"
  ttl          = 1800
  managed_zone = google_dns_managed_zone.dns_zone.0.name
  rrdatas      = each.value.regional_ip ? [google_compute_address.namespace_regional_public_ip[each.value.namespace].address] : [google_compute_global_address.namespace_public_ip[each.value.namespace].address]

  depends_on = [google_dns_managed_zone.dns_zone]
}

resource "google_dns_managed_zone" "dns_zone" {
  count = var.dns_enabled ? 1 : 0

  name        = replace(var.dns_domain, ".", "-")
  dns_name    = "${var.dns_domain}."
  description = "${var.dns_domain} root DNS zone"

  depends_on = [google_project_service.dns]
}
