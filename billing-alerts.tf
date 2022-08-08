locals {
  billing_budget_per_service = {
    for service_id in var.billing_budgets_per_service :
    service_id.name => service_id
  }
}

resource "google_billing_budget" "project_budget" {
  count = var.enable_billing_alerts ? 1 : 0

  billing_account = var.google_billing_account_id
  display_name    = "Billing Budget-${var.environment_name}"

  budget_filter {
    projects = ["projects/${data.google_project.project.number}"]
  }

  amount {
    specified_amount {
      currency_code = var.billing_currency_code
      units         = var.billing_project_units_amount
    }
  }

  dynamic "threshold_rules" {
    for_each = var.billing_project_threshold_rules
    content {
      threshold_percent = threshold_rules.value.threshold
      spend_basis       = threshold_rules.value.spend_type
    }
  }

  all_updates_rule {
    monitoring_notification_channels = google_monitoring_notification_channel.billing_email_alert.*.id
    schema_version                   = "1.0"
    disable_default_iam_recipients   = false
  }

  depends_on = [google_project_service.billing]
}

resource "google_billing_budget" "project_service_budget" {
  for_each = var.enable_billing_alerts ? local.billing_budget_per_service : {}

  billing_account = var.google_billing_account_id
  display_name    = "Billing Budget-${each.value.name}"

  budget_filter {
    projects = ["projects/${data.google_project.project.number}"]
    services = ["services/${each.value.service_id}"]
  }

  amount {
    specified_amount {
      currency_code = var.billing_currency_code
      units         = each.value.amount
    }
  }

  threshold_rules {
    threshold_percent = each.value.threshold_percent
    spend_basis       = each.value.spend_basis
  }

  all_updates_rule {
    monitoring_notification_channels = google_monitoring_notification_channel.billing_email_alert.*.id
    schema_version                   = "1.0"
    disable_default_iam_recipients   = false
  }

  depends_on = [google_project_service.billing]
}

resource "google_monitoring_notification_channel" "billing_email_alert" {
  count = var.enable_billing_alerts ? length(var.billing_email_address) : 0

  display_name = "Billing Email Alert for ${element(var.billing_email_address, count.index)}"
  type         = "email"

  labels = {
    email_address = element(var.billing_email_address, count.index)
  }
}

resource "google_project_service" "billing" {
  service = "billingbudgets.googleapis.com"
}
