resource "google_monitoring_alert_policy" "kube_event" {
  for_each = var.enable_k8s_containers_alerts ? var.k8s_containers_namespaces : []
  display_name = "Kubernetes Alerts - ${var.environment_name} - ${each.key}"

  combiner     = "OR"
  notification_channels = var.k8s_containers_alerts_type == "slack" ? [google_monitoring_notification_channel.kube_event_slack_channel[each.key].name] : google_monitoring_notification_channel.kube_event_email_channel.*.id

  conditions {
    display_name = "K8S Container Error Log(ENV: ${var.environment_name}, Namespace: ${each.key})"
    condition_threshold {
      filter          = <<EOT
metric.type="logging.googleapis.com/user/${google_logging_metric.kube_event[each.key].name}" AND
resource.type="k8s_container"
EOT
      duration        = var.k8s_containers_alerts_logs_duration
      threshold_value = var.k8s_containers_alerts_logs_threshold_value
      comparison      = "COMPARISON_GT"
      aggregations {
          alignment_period   = var.k8s_containers_alerts_logs_alignment_period
          per_series_aligner = var.k8s_containers_alerts_logs_per_series_aligner
          group_by_fields = ["container_name"]
      }
    }
  }

  conditions {
    display_name = "K8S Container CPU Limit Utilization reached ${var.k8s_containers_alerts_cpu_memory_threshold_value}(ENV: ${var.environment_name}, Namespace: ${each.key})"
    condition_threshold {
      filter          = <<EOT
metric.type="kubernetes.io/container/cpu/limit_utilization" AND
resource.type="k8s_container" AND
resource.labels.namespace_name="${each.key}"
EOT
      duration        = var.k8s_containers_alerts_cpu_memory_duration
      threshold_value = var.k8s_containers_alerts_cpu_memory_threshold_value
      comparison      = "COMPARISON_GT"
      aggregations {
          alignment_period   = var.k8s_containers_alerts_cpu_memory_alignment_period
          per_series_aligner = var.k8s_containers_alerts_cpu_memory_per_series_aligner
          group_by_fields = ["container_name"]
      }
    }
  }

  conditions {
    display_name = "K8S Container Memory Limit Utilization reached ${var.k8s_containers_alerts_cpu_memory_threshold_value}(ENV: ${var.environment_name}, Namespace: ${each.key})"
    condition_threshold {
      filter          = <<EOT
metric.type="kubernetes.io/container/memory/limit_utilization" AND
resource.type="k8s_container" AND
resource.labels.namespace_name="${each.key}"
EOT
      duration        = var.k8s_containers_alerts_cpu_memory_duration
      threshold_value = var.k8s_containers_alerts_cpu_memory_threshold_value
      comparison      = "COMPARISON_GT"
      aggregations {
          alignment_period   = var.k8s_containers_alerts_cpu_memory_alignment_period
          per_series_aligner = var.k8s_containers_alerts_cpu_memory_per_series_aligner
          group_by_fields = ["container_name"]
      }
    }
  }

  conditions {
    display_name = "K8S Container Restarted(ENV: ${var.environment_name}, Namespace: ${each.key})"
    condition_threshold {
      filter          = <<EOT
metric.type="kubernetes.io/container/restart_count" AND
resource.type="k8s_container" AND
resource.labels.namespace_name="${each.key}" AND
resource.labels.state="ACTIVE"
EOT
      duration        = var.k8s_containers_alerts_restarts_duration
      threshold_value = var.k8s_containers_alerts_restarts_threshold_value
      comparison      = "COMPARISON_GT"
      aggregations {
          alignment_period   = var.k8s_containers_alerts_restarts_alignment_period
          per_series_aligner = var.k8s_containers_alerts_restarts_per_series_aligner
          group_by_fields = ["container_name"]
      }
    }
  }

  conditions {
    display_name = "K8S Pod Error Log(ENV: ${var.environment_name}, Namespace: ${each.key})"
    condition_threshold {
      filter          = <<EOT
metric.type="logging.googleapis.com/user/${google_logging_metric.kube_pod_event[each.key].name}" AND
resource.type="k8s_pod"
EOT
      duration        = var.k8s_containers_alerts_pod_logs_duration
      threshold_value = var.k8s_containers_alerts_pod_logs_threshold_value
      comparison      = "COMPARISON_GT"
      aggregations {
          alignment_period   = var.k8s_containers_alerts_pod_logs_alignment_period
          per_series_aligner = var.k8s_containers_alerts_pod_logs_per_series_aligner
          group_by_fields = ["pod_name"]
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [google_logging_metric.kube_event]
}

resource "google_logging_metric" "kube_event" {
  for_each = var.enable_k8s_containers_alerts ? var.k8s_containers_namespaces : []
  name   = each.key

  filter = <<EOT
resource.type="k8s_container"
resource.labels.namespace_name="${each.key}"
severity>=ERROR
EOT
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

resource "google_logging_metric" "kube_pod_event" {
  for_each = var.enable_k8s_containers_alerts ? var.k8s_containers_namespaces : []
  name   = each.key

  filter = <<EOT
resource.type="k8s_pod"
resource.labels.namespace_name="${each.key}"
severity>=WARNING
EOT
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

resource "google_monitoring_notification_channel" "kube_event_slack_channel" {
  for_each = var.enable_k8s_containers_alerts && var.k8s_containers_alerts_type == "slack" ? var.k8s_containers_namespaces : []

  display_name = "${each.key} Kubernetes Containers Alert"
  type = "slack"
  labels = {
    channel_name = var.k8s_container_alerts_slack_channel_name
  }

  sensitive_labels {
    auth_token = var.slack_auth_token
  }
}

resource "google_monitoring_notification_channel" "kube_event_email_channel" {
  count = var.enable_k8s_containers_alerts && var.k8s_containers_alerts_type == "email" ? length(var.k8s_containers_alerts_email_address) : 0

  display_name = "Kubernetes Containers Email Alert for ${element(var.k8s_containers_alerts_email_address, count.index)}"
  type         = "email"

  labels = {
    email_address = element(var.k8s_containers_alerts_email_address, count.index)
  }
}