resource "helm_release" "sealed_secrets" {
  count      = var.sealed_secrets_enabled ? 1 : 0

  name       = "sealed-secrets"
  version    = var.sealed_secrets_chart_version
  namespace  = kubernetes_namespace.sealed_secrets.0.metadata.0.name

  chart      = "sealed-secrets"
  repository = "https://kubernetes-charts.storage.googleapis.com/"

  set {
    name = "image.repository"
    value = "quay.io/bitnami/sealed-secrets-controller"
  }

  set {
    name = "image.tag"
    value = var.sealed_secrets_version
  }

  set {
    name = "serviceAccount.create"
    value = "true"
  }

  set {
    name = "serviceAccount.name"
    value = "sealed-secrets"
  }

  set {
    name = "secretName"
    value = kubernetes_secret.sealed_secrets_tls.0.metadata.0.name
  }

  set {
    name = "crd.create"
    value = "true"
  }

  set {
    name = "crd.keep"
    value = "true"
  }
}

resource "kubernetes_secret" "sealed_secrets_tls" {
  count      = var.sealed_secrets_enabled ? 1 : 0
  
  type  = "kubernetes.io/tls"

  metadata {
    name      = "sealed-secrets-tls"
    namespace = kubernetes_namespace.sealed_secrets.0.metadata.0.name
    labels = {
      "sealedsecrets.bitnami.com/sealed-secrets-key" = "active"
    }
  }

  data = {
    "tls.crt" = tls_self_signed_cert.sealed_secrets.0.cert_pem
    "tls.key" = tls_private_key.sealed_secrets.0.private_key_pem
  }
}

resource "tls_self_signed_cert" "sealed_secrets" {
  count      = var.sealed_secrets_enabled ? 1 : 0

  key_algorithm   = tls_private_key.sealed_secrets.0.algorithm
  private_key_pem = tls_private_key.sealed_secrets.0.private_key_pem

  validity_period_hours = 210240
  early_renewal_hours = 48

  allowed_uses = [
    "encipher_only"
  ]

  dns_names = ["localhost"]

  subject {
    common_name  = "localhost"
    organization = "Coremaker"
  }
}

resource "tls_private_key" "sealed_secrets" {
  count      = var.sealed_secrets_enabled ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "kubernetes_namespace" "sealed_secrets" {
  count      = var.sealed_secrets_enabled ? 1 : 0

  metadata {
    name = "sealed-secrets"
  }
  depends_on = [google_container_cluster.kube, google_container_node_pool.kube_nodes]
}