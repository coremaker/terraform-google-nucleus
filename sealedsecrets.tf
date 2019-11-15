resource "helm_release" "sealed_secrets" {
  count      = var.sealed_secrets_enabled ? 1 : 0

  name       = "sealed-secrets"
  version    = "1.4.3"
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
    value = "sealed-secrets"
  }

  set {
    name = "crd.create"
    value = "true"
  }

  set {
    name = "crd.keep"
    value = "true"
  }

  depends_on = [kubernetes_cluster_role_binding.tiller_cluster_admin]
}

resource "kubernetes_namespace" "sealed_secrets" {
  count      = var.sealed_secrets_enabled ? 1 : 0

  metadata {
    name = "sealed-secrets"
  }
  depends_on = [google_container_cluster.kube, google_container_node_pool.kube_nodes]
}