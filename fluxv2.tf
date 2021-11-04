resource "helm_release" "fluxv2" {
    count = var.fluxv2_enabled ? 1 : 0

    name       = "fluxv2"
    namespace  = kubernetes_namespace.fluxv2.0.metadata.0.name
    chart = var.fluxv2_chart

    set {
        name = "gitRepository.url"
        value = var.fluxv2_git_url
    }

    set {
        name = "gitRepository.namespace"
        value = var.fluxv2_gitRepository_namespace
    }

    set {
        name = "gitRepository.branch"
        value = var.fluxv2_git_branch
    }

    set {
        name = "kustomization.path"
        value = var.fluxv2_git_path
    }

    set {
        name = "kustomization.namespace"
        value = var.fluxv2_kustomization_namespace
    }

    set {
        name = "gitRepository.secretName"
        value = "fluxv2-github-credentials"
    }

    set {
        name = "gitRepository.interval"
        value = var.fluxv2_gitRepository_interval
    }

    set {
        name = "kustomization.interval"
        value = var.fluxv2_kustomization_interval
    }

    depends_on = [kubernetes_namespace.fluxv2, kubernetes_secret.flux_secret]
}

resource "kubernetes_secret" "fluxv2_secret" {
    count = var.fluxv2_enabled ? 1 : 0

    metadata {
        name      = "fluxv2-github-credentials"
        namespace = kubernetes_namespace.fluxv2.0.metadata.0.name
    }

    data = {
        "identity" = tls_private_key.flux_secret.0.private_key_pem
        "identity.pub" = tls_private_key.flux_secret.0.public_key_pem
        "known_hosts" = file("${path.module}/github-known-hosts")
    }
}

resource "tls_private_key" "fluxv2_secret" {
    count = var.fluxv2_enabled ? 1 : 0

    algorithm = "RSA"
    rsa_bits  = "2048"
}

resource "kubernetes_namespace" "fluxv2" {
    count = var.fluxv2_enabled ? 1 : 0

    metadata {
        name = "flux-system"
    }
}