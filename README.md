[![Maintained by coremaker.io](https://img.shields.io/badge/maintained%20by-coremaker.io-green)](https://coremaker.io/)
[![Coremaker Docs](https://img.shields.io/badge/coremaker-docs-green)](https://coremaker.io/)

# Terraform Google Nucleus

This repository contains a [Terraform](https://www.terraform.io) module for running the main services on Google Cloud Platform.
This module is fully configurable !

## Kubernetes - k8s-coremaker

The k8s repository is based on [`Helm`] and it is used to install services in the [`Kubernetes`] cluster. In the k8s repo we are using three major tools [`flux`], [`kustomize`] and [`sealed-secrets`].

### Flux

Continuous delivery is a term that encapsulates a set of best practices that surround building, deploying and monitoring applications. The goal is to provide a sustainable model for maintaining and improving an application.

Flux is a tool that automates the deployment of containers to Kubernetes. It fills the automation void that exists between building and monitoring

Flux’s main feature is the automated synchronisation between a version control repository and a cluster. If you make any changes to your repository, those changes are automatically deployed to your cluster.

More information about [`flux`].

### Sealed-secrets

Encrypt your Secret into a SealedSecret, which is safe to store - even to a public repository. The SealedSecret can be decrypted only by the controller running in the target cluster and nobody else (not even the original author) is able to obtain the original Secret from the SealedSecret.

The certificates are stored in sealedsecret-keys folder, every k8s cluster has its own certificate with which its decrypting the secrets. The secret has to be resealed in every environment for sealed-secret to be able to decrypt it.

More information about [`sealed-secrets`].

Sealing example

#### Install kubeseal

```bash
brew install kubeseal
```

local/secret.yaml
```bash
apiVersion: v1
data:
    dbUrl: base64 encoded value
kind: Secret
metadata:
  creationTimestamp: null
  name: secretName
  namespace: coremaker
```
#### Seal the secrets

```bash
kubeseal --format=yaml --cert=sealedsecret-keys/dev.pem < local/secret.yaml > environments/qa/coremaker/sealed-secret-patch.yaml
```

## Dockerhub
### terraform-root

Docker Hub is a cloud-based repository in which we create, test, store and distribute container images.

## Terraform
### terraform-platform

Within this repository we install the terraform nucleus module and any other additionally terraform based resource.

All enviornments are controlled by [`Terraform Cloud`]

[`Terraform Cloud`] is an application that helps teams use Terraform together. It manages Terraform runs in a consistent and reliable environment, and includes easy access to shared state and secret data, access controls for approving changes to infrastructure, a private registry for sharing Terraform modules, detailed policy controls for governing the contents of Terraform configurations, and more.

## CI Pipelines and secrets management
### CI Pipelines
Continuous Integration (CI) is a development practice that requires developers to integrate code into a shared repository several times a day. Each check-in is then verified by an automated build, allowing teams to detect problems early.

[`Concourse`] is a pipeline-based continuous thing-doer.

The word "pipeline" is all the rage in CI these days, so being more specific about this term is kind of important; Concourse's pipelines are significantly different from the rest.

Pipelines are built around Resources, which represent all external state, and Jobs, which interact with them. Concourse pipelines represent a dependency flow, kind of like distributed Makefiles. Pipelines are designed to be self-contained so as to minimize server-wide configuration. Maximizing portability also mitigates risk, making it easier for projects to recover from CI disasters.

More information about [`concourse`].

### Secrets management

[`Vault`] is a tool for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, or certificates. [`Vault`] provides a unified interface to any secret, while providing tight access control and recording a detailed audit log.

A modern system requires access to a multitude of secrets: database credentials, API keys for external services, credentials for service-oriented architecture communication, etc. Understanding who is accessing what secrets is already very difficult and platform-specific. Adding on key rolling, secure storage, and detailed audit logs is almost impossible without a custom solution. This is where [`Vault`] steps in.

Storing secrets in vault allows concourse to access git repositories and the dockerhub project.

More information about [`vault`].

[`vault`]: https://www.vaultproject.io/docs/what-is-vault/
[`concourse`]: https://concourse-ci.org/
[`terraform`]: https://www.terraform.io
[`helm`]: https://helm.sh/
[`kubernetes`]: https://kubernetes.io/
[`sealed-secrets`]: https://github.com/bitnami-labs/sealed-secrets
[`kustomize`]: https://kustomize.io/
[`flux`]: https://docs.fluxcd.io/en/1.18.0/introduction.html
[`make`]: https://www.gnu.org/software/make
[`sed`]: https://www.gnu.org/software/sed
[`Terraform Cloud`]: https://www.terraform.io/docs/cloud/index.html