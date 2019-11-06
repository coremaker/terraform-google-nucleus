resource "helm_release" "flux" {
  count      = var.flux_enabled ? 1 : 0

  name       = "flux"
  version    = "0.15.0"
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
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "helmOperator.create"
    value = "true"
  }

  set {
    name  = "helmOperator.createCRD"
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

  depends_on = ["kubernetes_cluster_role_binding.tiller_cluster_admin"]
}

resource "kubernetes_namespace" "flux" {
  count      = var.flux_enabled ? 1 : 0

  metadata {
    name = "flux"
  }
  depends_on = ["google_container_cluster.kube", "google_container_node_pool.kube_nodes"]
}