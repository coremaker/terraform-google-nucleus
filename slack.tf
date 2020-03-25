locals {
  k8s_namespaces_slack = {
    for namespace in var.k8s_namespaces:
      namespace.name => namespace
    if namespace.uses_slack_alert
  }
}

resource "google_monitoring_alert_policy" "kube_event" {
  for_each = local.k8s_namespaces_slack
  display_name = "${google_container_cluster.kube.name} - ${each.key} - Alerts"

  combiner     = "OR"
  notification_channels = [
    google_monitoring_notification_channel.slack[each.key].name
  ]

  conditions {
    display_name = google_logging_metric.kube_event[each.key].name
    condition_threshold {
      filter          = <<EOT
metric.type="logging.googleapis.com/user/${google_logging_metric.kube_event[each.key].name}" AND
resource.type="k8s_container"
EOT
      duration        = "60s"
      threshold_value = 0
      comparison      = "COMPARISON_GT"
      aggregations {
          alignment_period   = "60s"
          per_series_aligner = "ALIGN_SUM"
       }
    }
  }

  depends_on = [google_logging_metric.kube_event, google_monitoring_notification_channel.slack, google_project_service.serviceusage]
}

resource "google_logging_metric" "kube_event" {
  for_each = local.k8s_namespaces_slack
  name   = each.key

  filter = <<EOT
resource.type="k8s_container"
resource.labels.namespace_name="${each.key}"
severity="ERROR"
EOT
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }

  depends_on = [google_project_service.serviceusage]
}

resource "google_monitoring_notification_channel" "slack" {
  for_each = local.k8s_namespaces_slack

  display_name = "${each.key}-Services Alert"
  type = "slack"
  labels = {
    auth_token = var.slack_auth_token
    channel_name = "${each.key}-${var.environment_name}-alerts"
  }

  depends_on = [google_project_service.serviceusage]
}