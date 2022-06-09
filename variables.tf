# Google

variable "google_project_id" {
  description = "The ID of the project you want to create the resources within."
}
variable "google_region" {
  description = "Region where to create the resources."
}
variable "google_zone" {
  description = "Zone where to create the resources."
}
variable "environment_name" {
  description = "Environment name, used in the name of main resources."
}
# IAM

variable "project_admins" {
  type = set(string)
  description = "List of project admins to be added."
}

variable "project_editors" {
  type = set(string)
  description = "List of project editors to be added."
}

variable "project_viewers" {
  type = set(string)
  description = "List of project viewers to be added."
}

# Google Kubernetes Engine

variable "gke_cluster_name" {
  description = "Name to be used for the cluster"
}

variable "gke_release_channel" {
  default = "UNSPECIFIED"
  description = "Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters"
}

variable "gke_enable_shielded_nodes" {
  type    = bool
  default = false
  description = "Enable Shielded Nodes features on all nodes in this cluster"
}

variable "gke_node_auto_upgrade" {
  type    = bool
  default = false // false only works with UNSPECIFIED release channel
  description = "Whether the nodes will be automatically upgraded."
}

variable "gke_node_auto_repair" {
  type    = bool
  default = true
  description = "Whether the nodes will be automatically repaired."
}

variable "gke_node_pools" {
  type = list(object({
    name           = string
    min_node_count = number
    max_node_count = number
    machine_type   = string
    image_type     = string
    taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
  default = [{
    name           = "nodes"
    min_node_count = 1
    max_node_count = 3
    machine_type   = "n1-standard-1"
    image_type     = "cos_containerd"
    taints         = []
  }]
  description = "List of node pools to be created within the cluster."
}

variable "gke_node_locations" {
  type    = set(string)
  default = ["europe-west2-a"]
}

variable "gke_cluster_resource_labels" {
  type        = map(string)
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster"
  default     = {}
}

variable "k8s_namespaces" {
  type = list(object({
    name          = string
    has_public_ip = bool
    dns_records   = set(string)
  }))
  description = "List of namespaces to be created."
}

# FLUX
variable "flux_enabled" {
  type    = bool
  default = true
  description = "Enable the creation of flux resources."
}

# Fluxv2
variable "fluxv2_enabled" {
  type    = bool
  default = false
  description = "Enable the creation of fluxv2 resources."
}
# DNS
variable "dns_enabled" {
  type    = bool
  default = false
  description = "Enable/Disable DNS resources"
}

variable "dns_domain" {
  description = "The DNS name of the managed zone."
}

# CERT-MANAGER
variable "cert_manager_enabled" {
  type    = bool
  default = true
  description = "Enable the creation of cert-manager resources."
}

# Sealed secrets
variable "sealed_secrets_enabled" {
  type    = bool
  default = true
  description = "Enable the creation of sealed-secrets resources."
}

# Alerting
## GCP Billing Alerts
variable "enable_billing_alerts" {
  type    = bool
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
  type = list(object({
    threshold  = number
    spend_type = string
  }))
  default = [
    {
      threshold  = 1.0
      spend_type = "FORECASTED_SPEND"
    },
    {
      threshold  = 1.2
      spend_type = "FORECASTED_SPEND"
    }
  ]
}

variable "billing_email_address" {
  type    = list(string)
  default = ["address@example.com"]
}

variable "billing_budgets_per_service" {
  type = list(object({
    name              = string
    service_id        = string
    amount            = number
    threshold_percent = string
    spend_basis       = string
  }))
  default = []
}

## Kubernetes Alerts
### These alerts are based on pod logs with severity ERROR
variable "enable_k8s_containers_alerts" {
  type    = bool
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
  type    = string
  default = "slack"
}

variable "k8s_container_alerts_slack_channel_name" {
  type    = string
  default = ""
}

variable "k8s_containers_alerts_email_address" {
  type    = list(string)
  default = ["address@example.com"]
}

#Logs
variable "k8s_containers_alerts_logs_duration" {
  type    = string
  default = "300s"
}

variable "k8s_containers_alerts_logs_threshold_value" {
  type    = number
  default = 0
}

variable "k8s_containers_alerts_logs_alignment_period" {
  type    = string
  default = "300s"
}

variable "k8s_containers_alerts_logs_per_series_aligner" {
  type    = string
  default = "ALIGN_SUM"
}

#CPU and MEMORY utilization
variable "k8s_containers_alerts_cpu_memory_duration" {
  type    = string
  default = "60s"
}

variable "k8s_containers_alerts_cpu_memory_threshold_value" {
  type    = number
  default = 0.9
}

variable "k8s_containers_alerts_cpu_memory_alignment_period" {
  type    = string
  default = "300s"
}

variable "k8s_containers_alerts_cpu_memory_per_series_aligner" {
  type    = string
  default = "ALIGN_MEAN"
}

#Container restarts
variable "k8s_containers_alerts_restarts_duration" {
  type    = string
  default = "60s"
}

variable "k8s_containers_alerts_restarts_threshold_value" {
  type    = number
  default = 0
}

variable "k8s_containers_alerts_restarts_alignment_period" {
  type    = string
  default = "300s"
}

variable "k8s_containers_alerts_restarts_per_series_aligner" {
  type    = string
  default = "ALIGN_DELTA"
}

#Pod warnings and errors
variable "k8s_containers_alerts_pod_logs_duration" {
  type    = string
  default = "300s"
}

variable "k8s_containers_alerts_pod_logs_threshold_value" {
  type    = number
  default = 0
}

variable "k8s_containers_alerts_pod_logs_alignment_period" {
  type    = string
  default = "300s"
}

variable "k8s_containers_alerts_pod_logs_per_series_aligner" {
  type    = string
  default = "ALIGN_SUM"
}