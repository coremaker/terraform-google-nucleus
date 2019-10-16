# Google

variable "project_id" {}
variable "region" {}
variable "zone" {}
variable "project_number" {}

# IAM

variable "project_admins" {
  type = "list"
}

variable "project_editors" {}

variable "project_readers" {}

# Kubernetes - K8S

variable "k8s_cluster_name" {}

variable "k8s_node_count" {}

variable "k8s_node_type" {}

variable "k8s_namespaces" {
    type    = list(object({
    name = string # Name of the namespace
    has_public_ip = bool
    dns_records = string
    uses_postgres = bool # If set true postgres_enabled should be true
    uses_mysql = bool # If set true mysql_enabled should be true
  }))
}

# HELM

variable "tiller_version" {}

# FLUX

variable "flux_repository_name" {}

variable "flux_version" {}

variable "flux_enabled" {
    default = false
    type = bool
}

# POSTGRES

variable "postgres_machine_type" {}

variable "postgres_database_version" {
    default = "POSTGRES_11" # Postgres version
}

variable "postgres_enabled" {
    default = false # Enable and disable postgres
    type = bool
}

# MYSQL

variable "mysql_machine_type" {
    # Mysql machine type
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
    default = "v0.10.1"
}

variable "cert_manager_enabled" {
    default = false
    type = bool
}