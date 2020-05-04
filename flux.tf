resource "helm_release" "helm_operator" {
  count      = var.flux_enabled ? 1 : 0

  name       = "helm-operator"
  version    = "1.0.1"
  namespace  = kubernetes_namespace.flux.0.metadata.0.name

  chart      = "helm-operator"
  repository = "https://charts.fluxcd.io"

  set {
    name  = "git.ssh.secretName"
    value = kubernetes_secret.flux_secret.0.metadata.0.name
  }

  set {
    name = "image.tag"
    value = var.helm_operator
  }

  set {
    name = "helm.versions"
    value = "v3"
  }
}

resource "helm_release" "flux" {
  count      = var.flux_enabled ? 1 : 0

  name       = "flux"
  version    = "1.3.0"
  namespace  = kubernetes_namespace.flux.0.metadata.0.name

  chart      = "flux"
  repository = "https://charts.fluxcd.io"

  set {
    name  = "git.url"
    value = var.flux_git_url
  }

  set {
    name = "git.path"
    value = var.flux_git_path
  }

  set {
    name  = "git.secretName"
    value = kubernetes_secret.flux_secret.0.metadata.0.name
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name = "image.tag"
    value = var.flux_version
  }

  set {
    name = "manifestGeneration"
    value = var.flux_manifest_generation
  }
}

resource "kubernetes_secret" "flux_secret" {
  count      = var.flux_enabled ? 1 : 0
  
  metadata {
    name      = "flux-secret"
    namespace = kubernetes_namespace.flux.0.metadata.0.name
  }

  data = {
    "identity" = tls_private_key.flux_secret.0.private_key_pem
  }
}

resource "tls_private_key" "flux_secret" {
  count      = var.flux_enabled ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "kubernetes_namespace" "flux" {
  count      = var.flux_enabled ? 1 : 0

  metadata {
    name = "flux"
  }
  depends_on = [google_container_cluster.kube, google_container_node_pool.kube_nodes]
}