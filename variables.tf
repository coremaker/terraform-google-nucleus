# Google

variable "google_project_id" {}
variable "google_region" {}
variable "google_zone" {}
variable "environment_name" {}
# IAM

variable "project_admins" {
    type = set(string)
}

variable "project_editors" {
    type = set(string)
}

variable "project_viewers" {
    type = set(string)
}

# Kubernetes - K8S

variable "k8s_cluster_name" {}

variable "k8s_release_channel" {
    default = "UNSPECIFIED"
}

variable "k8s_enable_shielded_nodes" {
    type = bool
    default = false
}

variable "k8s_node_auto_upgrade" {
    type = bool
    default = false // false only works with UNSPECIFIED release channel 
}

variable "k8s_node_auto_repair" {
    type = bool
    default = true
}

variable "k8s_node_pools" {
    type    = list(object({
        name = string
        min_node_count = number
        max_node_count = number
        machine_type = string
        image_type = string
        taints = list(object({
            key = string
            value = string
            effect = string
        }))
    }))
    default = [{
        name = "nodes"
        min_node_count = 1
        max_node_count = 3
        machine_type = "n1-standard-1"
        image_type = "cos_containerd"
        taints = []
    }]
}

variable "k8s_namespaces" {
    type    = list(object({
        name = string
        has_public_ip = bool
        dns_records = set(string)
  }))
}

# FLUX
variable "flux_enabled" {
    type = bool
    default = true
}

# Fluxv2
variable "fluxv2_enabled" {
    type = bool
    default = false
}
# DNS
variable "dns_domain" {}

variable "dns_enabled" {
    type = bool
    default = false
}

# CERT-MANAGER
variable "cert_manager_enabled" {
    type = bool
    default = true
}

# Sealed secrets
variable "sealed_secrets_enabled" {
    type = bool
    default = true
}

# Alerting
## GCP Billing Alerts
variable "enable_billing_alerts" {
    type = bool
    default = false
}

variable "google_billing_account_id" {
    default = ""
}

variable "billing_currency_code" {
    default = "GBP"
}

variable "billing_project_units_amount" {
    default = "500"
}

variable "billing_project_threshold_rules" {
    type    = list(object({
        threshold = number
        spend_type = string
    }))
    default = [
        {
            threshold = 1.0
            spend_type = "FORECASTED_SPEND"
        },
        {
            threshold = 1.2
            spend_type = "FORECASTED_SPEND"
        }
    ]
}

variable "billing_email_address" {
    type = list(string)
    default = ["address@example.com"]
}

variable "billing_budgets_per_service" {
    type    = list(object({
        name = string
        service_id = string
        amount = number
        threshold_percent = string
        spend_basis = string
    }))
    default = []
}

## Kubernetes Alerts
### These alerts are based on pod logs with severity ERROR
variable "enable_k8s_containers_alerts" {
    type = bool
    default = false
}

variable "slack_auth_token" {
    default = "token" # Needs to be replaced with a working token
} 

variable "k8s_containers_namespaces" {
  type    = set(string)
  default = ["default"]
}

### slack or email supported only
variable "k8s_containers_alerts_type" {
    type = string
    default = "slack"
}

variable "k8s_container_alerts_slack_channel_name" {
    type = string
    default = ""
}

variable "k8s_containers_alerts_email_address" {
    type = list(string)
    default = ["address@example.com"]
}

#Logs
variable "k8s_containers_alerts_logs_duration" {
    type = string
    default = "300s"
}

variable "k8s_containers_alerts_logs_threshold_value" {
    type = number
    default = 0
}

variable "k8s_containers_alerts_logs_alignment_period" {
    type = string
    default = "300s"
}

variable "k8s_containers_alerts_logs_per_series_aligner" {
    type = string
    default = "ALIGN_SUM"
}

#CPU and MEMORY utilization
variable "k8s_containers_alerts_cpu_memory_duration" {
    type = string
    default = "60s"
}

variable "k8s_containers_alerts_cpu_memory_threshold_value" {
    type = number
    default = 0.9
}

variable "k8s_containers_alerts_cpu_memory_alignment_period" {
    type = string
    default = "300s"  
}

variable "k8s_containers_alerts_cpu_memory_per_series_aligner" {
    type = string
    default = "ALIGN_MEAN"
}

#Container restarts
variable "k8s_containers_alerts_restarts_duration" {
    type = string
    default = "60s"
}

variable "k8s_containers_alerts_restarts_threshold_value" {
    type = number
    default = 0
}

variable "k8s_containers_alerts_restarts_alignment_period" {
    type = string
    default = "300s"  
}

variable "k8s_containers_alerts_restarts_per_series_aligner" {
    type = string
    default = "ALIGN_DELTA"
}

#Pod warnings and errors
variable "k8s_containers_alerts_pod_logs_duration" {
    type = string
    default = "300s"
}

variable "k8s_containers_alerts_pod_logs_threshold_value" {
    type = number
    default = 0
}

variable "k8s_containers_alerts_pod_logs_alignment_period" {
    type = string
    default = "300s"  
}

variable "k8s_containers_alerts_pod_logs_per_series_aligner" {
    type = string
    default = "ALIGN_SUM"
}