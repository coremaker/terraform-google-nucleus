resource "kubernetes_cluster_role_binding" "tiller_cluster_admin" {
  metadata {
    name = "tiller"
  }

  subject {
    kind = "User"
    name = "system:serviceaccount:kube-system:${kubernetes_service_account.tiller.metadata.0.name}"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind  = "ClusterRole"
    name = "cluster-admin"
  }

  depends_on = [kubernetes_service_account.tiller]
}

resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }

  depends_on = [google_container_cluster.kube, google_container_node_pool.kube_nodes]
}