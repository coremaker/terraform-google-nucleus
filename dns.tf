locals {
  dns_records = {
    for namespace in var.k8s_namespaces:
      namespace.dns_records => namespace.name
    if namespace.has_public_ip
  }
}

resource "google_dns_record_set" "dns_record" {
  for_each = local.dns_records

  name = "${each.key}." # DOMAIN NAME
  project = "${var.project_id}"
  type = "A"
  ttl = 1800
  managed_zone = "${google_dns_managed_zone.dns_zone.0.name}"
  rrdatas = ["${google_compute_global_address.namespace_public_ip[each.value].address}"] #PUBLIC IP

  depends_on = ["google_dns_managed_zone.dns_zone"]
}

resource "google_dns_managed_zone" "dns_zone" {
  count      = "${var.dns_enabled ? 1 : 0}"

  project = "${var.project_id}"

  name = "${replace(var.dns_domain,".","-")}"
  dns_name = "${var.dns_domain}."
  description = "${var.dns_domain} root DNS zone"

  depends_on = ["google_project_service.dns"]
}