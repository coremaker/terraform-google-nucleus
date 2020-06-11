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

variable "k8s_node_pools" {
    type    = list(object({
        name = string
        node_count = number
        machine_type = string
        taints = list(object({
            key = string
            value = string
            effect = string
        }))
    }))
    default = [{
        name = "nodes"
        node_count = 1
        machine_type = "n1-standard-1"
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
        uses_mongodb_atlas = bool
        uses_slack_alert = bool # If true you have to manually create the slack channel on slack
        uses_redis = bool
  }))
}

# FLUX

variable "flux_git_url" {}

variable "flux_git_path" {}

variable "flux_chart_version" {
    default = "1.3.0"
}

variable "flux_version" {
    default = "1.19.0"
}

variable "flux_enabled" {
    default = true
    type = bool
}

variable "flux_manifest_generation" {
    default = true
    type = bool
}

variable "helm_operator_chart_version" {
    default = "1.0.1"
}

variable "helm_operator" {
    default = "1.0.1"
}

# POSTGRES

variable "postgres_machine_type" {
    default = "db-f1-micro"
}

variable "postgres_database_version" {
    default = "POSTGRES_11" # Postgres version
}

variable "postgres_enabled" {
    default = false # Enable and disable postgres
    type = bool
}

# MYSQL

variable "mysql_machine_type" {
    default = "db-f1-micro"
}

variable "mysql_database_version" {
    default = "MYSQL_5_7" # Mysql database version
}

variable "mysql_enabled" {
    default = false # Enable and disable mysql
    type = bool
}

# DNS

variable "dns_domain" {}

variable "dns_enabled" {
    default = false
    type = bool
}

# CERT-MANAGER

variable "cert_manager_helm_version" {
    default = "v0.14.2"
}

variable "cert_manager_enabled" {
    default = true
    type = bool
}

# Sealed secrets

variable "sealed_secrets_enabled" {
    default = true
    type = bool
}

variable "sealed_secrets_chart_version" {
    default = "1.5.0"
}

variable "sealed_secrets_version" {
    default = "v0.9.5"
}

# Slack alert channel
variable "slack_auth_token" {
    default = "token" # Needs to be replaced with a working token
}

# MongoDB Atlas

variable "mongodb_atlas_enabled" {
    default = false
    type = bool
}

variable "mongodb_atlas_instance_size_name" {
    default = "M2"
    description = "The mongodbatlas instance size. Possible values are: M2, M5, M10, M20, M30 etc. IMPORTANT: Upgrading from M2/M5 to M10 and above will recreate the cluster and the data will be lost so a data migration must be planned ahead."
}

variable "mongodb_atlas_version" {
    default = "4.2"
}

variable "mongodb_atlas_disk_size" {
    default = 2
}

variable "mongodb_atlas_region" {
    default = "WESTERN_EUROPE"
}

variable "mongodb_atlas_org_id" {
    default = ""
}

# Reddis

variable "redis_enabled" {
    type = bool
    default = false
}

variable "redis_tier" {
    default = "STANDARD_HA"
}

variable "redis_version" {
    default = "REDIS_4_0"
}

variable "redis_memory_size" {
    default = 1
}