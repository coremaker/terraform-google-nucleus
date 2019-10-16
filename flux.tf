resource "helm_release" "flux" {
  count      = "${var.flux_enabled ? 1 : 0}"

  name       = "flux"
  version    = "0.14.1"
  namespace  = "${kubernetes_namespace.flux.0.metadata.0.name}"

  chart      = "fluxcd/flux"
  repository = "${data.helm_repository.fluxcd.0.metadata.0.name}"

  set {
    name  = "git.url"
    value = "${var.flux_repository_name}"
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
    value = "${var.flux_version}"
  }

  depends_on = ["kubernetes_cluster_role_binding.tiller_cluster_admin"]
}

data "helm_repository" "fluxcd" {
  count      = "${var.flux_enabled ? 1 : 0}"

    name = "fluxcd"
    url  = "https://charts.fluxcd.io"
}

resource "kubernetes_namespace" "flux" {
  count      = "${var.flux_enabled ? 1 : 0}"

  metadata {
    name = "flux"
  }
  depends_on = ["google_container_cluster.kube", "google_container_node_pool.kube_nodes"]
}