resource "helm_release" "fluxv2" {
    count = var.fluxv2_enabled ? 1 : 0

    name       = "fluxv2"
    namespace  = kubernetes_namespace.fluxv2.0.metadata.0.name
    chart = format("%s/helm-charts/fluxv2", path.module)

    set {
        name = "gitRepository.url"
        value = var.fluxv2_git_url
    }

    set {
        name = "common.path"
        value = var.fluxv2_git_path
    }

    set {
        name = "gitRepository.branch"
        value = var.fluxv2_git_branch
    }

    set {
        name = "imageAutomation.checkoutBranch"
        value = var.fluxv2_imageAutomation_checkout_branch
    }

    set {
        name = "imageAutomation.pushBranch"
        value = var.fluxv2_imageAutomation_push_branch
    }

    set {
        name = "gitRepository.secretName"
        value = kubernetes_secret.fluxv2_github_secret.0.metadata.0.name
    }

    set {
        name = "gitRepository.interval"
        value = var.fluxv2_gitRepository_interval
    }

    set {
        name = "kustomization.interval"
        value = var.fluxv2_kustomization_interval
    }

    set {
        name = "imageAutomation.interval"
        value = var.fluxv2_imageAutomation_interval
    }

    depends_on = [helm_release.fluxv2_controllers]
}

resource "helm_release" "fluxv2_controllers" {
    count = var.fluxv2_enabled ? 1 : 0

    name       = "fluxv2-controllers"
    namespace  = kubernetes_namespace.fluxv2.0.metadata.0.name
    chart = var.fluxv2_chart

    depends_on = [kubernetes_namespace.fluxv2, kubernetes_secret.flux_secret]
}

resource "kubernetes_secret" "fluxv2_github_secret" {
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

resource "kubernetes_secret" "fluxv2_gcr_secret" {
    count = var.fluxv2_enabled ? 1 : 0
    type = "kubernetes.io/dockerconfigjson"

    metadata {
        name      = "fluxv2-gcr-credentials"
        namespace = kubernetes_namespace.fluxv2.0.metadata.0.name
    }

    data = {
        ".dockerconfigjson" = jsonencode({
        auths = {
            "eu.gcr.io" = {
            auth = "_json_key:${base64decode(google_service_account_key.fluxv2_container_registry.0.private_key)}"
            }
        }
        })
    }
}

resource "google_service_account_key" "fluxv2_container_registry" {
    count = var.fluxv2_enabled ? 1 : 0

    service_account_id = google_service_account.fluxv2.0.id
    public_key_type    = "TYPE_X509_PEM_FILE"
    private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"
}

resource "google_service_account" "fluxv2" {
    count = var.fluxv2_enabled ? 1 : 0

    account_id   = "fluxv2"
    display_name = "fluxv2 service account"
}

resource "kubernetes_namespace" "fluxv2" {
    count = var.fluxv2_enabled ? 1 : 0

    metadata {
        name = "flux-system"
    }
}