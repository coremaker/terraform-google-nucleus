# Google

variable "google_project_id" {}
variable "google_region" {}
variable "google_zone" {}

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

variable "k8s_node_count" {}

variable "k8s_node_type" {}

variable "k8s_namespaces" {
    type    = list(object({
    name = string # Name of the namespace
    has_public_ip = bool
    dns_records = set(string)
    uses_postgres = bool # If set true postgres_enabled should be true
    uses_mysql = bool # If set true mysql_enabled should be true
  }))
}

# HELM

variable "tiller_version" {
    default = "v2.15.1"
}

# FLUX

variable "flux_git_url" {}

variable "flux_git_path" {}

variable "flux_version" {
    default = "1.15.0"
}

variable "flux_enabled" {
    default = true
    type = bool
}

variable "flux_manifest_generation" {
    default = true
    type = bool
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
    default = "v0.11.0"
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

variable "sealed_secrets_version" {
    default = "v0.9.1"
}