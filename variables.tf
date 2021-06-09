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
        name = string # Name of the namespace
        has_public_ip = bool
        dns_records = set(string)
        uses_postgres = bool # If set true postgres_enabled should be true
        uses_mysql = bool # If set true mysql_enabled should be true
        uses_slack_alert = bool # If true you have to manually create the slack channel on slack
  }))
}

# FLUX

variable "flux_git_url" {}

variable "flux_git_path" {}

variable "flux_chart_version" {
    default = "1.6.0"
}

variable "flux_version" {
    default = "1.21.0"
}

variable "flux_enabled" {
    type = bool
    default = true
}

variable "flux_manifest_generation" {
    type = bool
    default = true
}

variable "helm_operator_chart_version" {
    default = "1.2.0"
}

variable "helm_operator" {
    default = "1.2.0"
}

# POSTGRES

variable "postgres_machine_type" {
    default = "db-f1-micro"
}

variable "postgres_disk_size" {
    default = "10"
}

variable "postgres_database_version" {
    default = "POSTGRES_11" # Postgres version
}

variable "postgres_enabled" {
    type = bool
    default = false # Enable and disable postgres
}

# MYSQL

variable "mysql_machine_type" {
    default = "db-f1-micro"
}

variable "mysql_disk_size" {
    default = "10"
}

variable "mysql_database_version" {
    default = "MYSQL_5_7" # Mysql database version
}

variable "mysql_enabled" {
    type = bool
    default = false # Enable and disable mysql
}

# DNS

variable "dns_domain" {}

variable "dns_enabled" {
    type = bool
    default = false
}

# CERT-MANAGER

variable "cert_manager_helm_version" {
    default = "v1.2.0"
}

variable "cert_manager_enabled" {
    type = bool
    default = true
}

# Sealed secrets

variable "sealed_secrets_enabled" {
    type = bool
    default = true
}

variable "sealed_secrets_chart_version" {
    default = "1.12.1"
}

variable "sealed_secrets_version" {
    default = "v0.13.1"
}

# Slack alert channel
variable "slack_auth_token" {
    default = "token" # Needs to be replaced with a working token
}

variable "alert_policy_threshold_duration" {
    default = "86400s"
}