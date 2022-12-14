[![Maintained by coremaker.io](https://img.shields.io/badge/maintained%20by-coremaker.io-green)](https://coremaker.io/)

# Terraform Google Nucleus

This repository contains a [Terraform](https://www.terraform.io) module for running the main services on Google Cloud Platform.
This module is fully configurable!

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.32.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.32.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_gke_hub_feature.mesh](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_gke_hub_feature) | resource |
| [google-beta_google_gke_hub_membership.membership](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_gke_hub_membership) | resource |
| [google_billing_budget.project_budget](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_budget) | resource |
| [google_billing_budget.project_service_budget](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/billing_budget) | resource |
| [google_compute_address.namespace_regional_public_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_global_address.namespace_public_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_global_address.private_ip_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.container_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_container_cluster.kube](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.kube_nodes](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |
| [google_dns_managed_zone.dns_zone](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_record_set.dns_record](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_logging_metric.kube_event](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_metric) | resource |
| [google_logging_metric.kube_pod_event](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_metric) | resource |
| [google_monitoring_alert_policy.kube_event](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |
| [google_monitoring_notification_channel.billing_email_alert](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_monitoring_notification_channel.kube_event_email_channel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_monitoring_notification_channel.kube_event_slack_channel](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |
| [google_project_iam_binding.container_editors](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_binding.container_readers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_binding.editors](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_binding.project_viewers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_member.cert_manager_account_dns_admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudsql_editors_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.cloudsql_readers_member](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.container_admins](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.anthos](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.billing](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.compute](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.container](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.containerregistry](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.dns](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.iam](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.logging](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.mesh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.monitoring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.serviceusage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.storage_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.storage_component](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.cert_manager_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.fluxv2](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.cert_manager_account_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_service_account_key.fluxv2_container_registry](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_service_networking_connection.private_vpc_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [tls_private_key.flux_secret](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.fluxv2_secret](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.sealed_secrets](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.sealed_secrets](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_anthos_enabled"></a> [anthos\_enabled](#input\_anthos\_enabled) | Anthos | `bool` | `false` | no |
| <a name="input_billing_budgets_per_service"></a> [billing\_budgets\_per\_service](#input\_billing\_budgets\_per\_service) | n/a | <pre>list(object({<br>    name              = string<br>    service_id        = string<br>    amount            = number<br>    threshold_percent = string<br>    spend_basis       = string<br>  }))</pre> | `[]` | no |
| <a name="input_billing_currency_code"></a> [billing\_currency\_code](#input\_billing\_currency\_code) | n/a | `string` | `"GBP"` | no |
| <a name="input_billing_email_address"></a> [billing\_email\_address](#input\_billing\_email\_address) | n/a | `list(string)` | <pre>[<br>  "address@example.com"<br>]</pre> | no |
| <a name="input_billing_project_threshold_rules"></a> [billing\_project\_threshold\_rules](#input\_billing\_project\_threshold\_rules) | n/a | <pre>list(object({<br>    threshold  = number<br>    spend_type = string<br>  }))</pre> | <pre>[<br>  {<br>    "spend_type": "FORECASTED_SPEND",<br>    "threshold": 1<br>  },<br>  {<br>    "spend_type": "FORECASTED_SPEND",<br>    "threshold": 1.2<br>  }<br>]</pre> | no |
| <a name="input_billing_project_units_amount"></a> [billing\_project\_units\_amount](#input\_billing\_project\_units\_amount) | n/a | `string` | `"500"` | no |
| <a name="input_cert_manager_enabled"></a> [cert\_manager\_enabled](#input\_cert\_manager\_enabled) | Enable the creation of cert-manager resources. | `bool` | `true` | no |
| <a name="input_dns_domain"></a> [dns\_domain](#input\_dns\_domain) | The DNS name of the managed zone. | `string` | n/a | yes |
| <a name="input_dns_enabled"></a> [dns\_enabled](#input\_dns\_enabled) | Enable/Disable DNS resources | `bool` | `false` | no |
| <a name="input_enable_billing_alerts"></a> [enable\_billing\_alerts](#input\_enable\_billing\_alerts) | Alerting # GCP Billing Alerts | `bool` | `false` | no |
| <a name="input_enable_k8s_containers_alerts"></a> [enable\_k8s\_containers\_alerts](#input\_enable\_k8s\_containers\_alerts) | # Kubernetes Alerts ## These alerts are based on pod logs with severity ERROR | `bool` | `false` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Environment name, used in the name of main resources. | `string` | n/a | yes |
| <a name="input_flux_enabled"></a> [flux\_enabled](#input\_flux\_enabled) | Enable the creation of flux resources. | `bool` | `true` | no |
| <a name="input_fluxv2_enabled"></a> [fluxv2\_enabled](#input\_fluxv2\_enabled) | Enable the creation of fluxv2 resources. | `bool` | `false` | no |
| <a name="input_gke_cluster_name"></a> [gke\_cluster\_name](#input\_gke\_cluster\_name) | Name to be used for the cluster | `string` | n/a | yes |
| <a name="input_gke_cluster_resource_labels"></a> [gke\_cluster\_resource\_labels](#input\_gke\_cluster\_resource\_labels) | The GCE resource labels (a map of key/value pairs) to be applied to the cluster | `map(string)` | `{}` | no |
| <a name="input_gke_enable_shielded_nodes"></a> [gke\_enable\_shielded\_nodes](#input\_gke\_enable\_shielded\_nodes) | Enable Shielded Nodes features on all nodes in this cluster | `bool` | `false` | no |
| <a name="input_gke_enabled"></a> [gke\_enabled](#input\_gke\_enabled) | Enable/Disable GKE resources creation | `bool` | `true` | no |
| <a name="input_gke_node_auto_repair"></a> [gke\_node\_auto\_repair](#input\_gke\_node\_auto\_repair) | Whether the nodes will be automatically repaired. | `bool` | `true` | no |
| <a name="input_gke_node_auto_upgrade"></a> [gke\_node\_auto\_upgrade](#input\_gke\_node\_auto\_upgrade) | Whether the nodes will be automatically upgraded. | `bool` | `false` | no |
| <a name="input_gke_node_locations"></a> [gke\_node\_locations](#input\_gke\_node\_locations) | n/a | `list(string)` | <pre>[<br>  "europe-west2-a"<br>]</pre> | no |
| <a name="input_gke_node_pools"></a> [gke\_node\_pools](#input\_gke\_node\_pools) | List of node pools to be created within the cluster. | <pre>list(object({<br>    name           = string<br>    node_count     = optional(number, 1)<br>    autoscaling    = optional(bool, true)<br>    min_node_count = optional(number)<br>    max_node_count = optional(number)<br>    machine_type   = optional(string, "n1-standard-1")<br>    image_type     = optional(string, "cos_containerd")<br>    disk_size_gb   = optional(string, "100")<br>    disk_type      = optional(string, "pd-ssd")<br>    spot           = optional(string, "false")<br>    node_locations = optional(list(string))<br>    taints = optional(list(object({<br>      key    = string<br>      value  = string<br>      effect = string<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_gke_regional"></a> [gke\_regional](#input\_gke\_regional) | Whether is a regional cluster (zonal cluster if set false). | `bool` | `true` | no |
| <a name="input_gke_release_channel"></a> [gke\_release\_channel](#input\_gke\_release\_channel) | Configuration options for the Release channel feature, which provide more control over automatic upgrades of your GKE clusters | `string` | `"UNSPECIFIED"` | no |
| <a name="input_google_billing_account_id"></a> [google\_billing\_account\_id](#input\_google\_billing\_account\_id) | n/a | `string` | `""` | no |
| <a name="input_google_project_id"></a> [google\_project\_id](#input\_google\_project\_id) | The ID of the project you want to create the resources within. | `string` | n/a | yes |
| <a name="input_google_region"></a> [google\_region](#input\_google\_region) | Region where to create the resources. | `string` | n/a | yes |
| <a name="input_k8s_container_alerts_slack_channel_name"></a> [k8s\_container\_alerts\_slack\_channel\_name](#input\_k8s\_container\_alerts\_slack\_channel\_name) | n/a | `string` | `""` | no |
| <a name="input_k8s_containers_alerts_cpu_memory_alignment_period"></a> [k8s\_containers\_alerts\_cpu\_memory\_alignment\_period](#input\_k8s\_containers\_alerts\_cpu\_memory\_alignment\_period) | n/a | `string` | `"300s"` | no |
| <a name="input_k8s_containers_alerts_cpu_memory_duration"></a> [k8s\_containers\_alerts\_cpu\_memory\_duration](#input\_k8s\_containers\_alerts\_cpu\_memory\_duration) | CPU and MEMORY utilization | `string` | `"60s"` | no |
| <a name="input_k8s_containers_alerts_cpu_memory_per_series_aligner"></a> [k8s\_containers\_alerts\_cpu\_memory\_per\_series\_aligner](#input\_k8s\_containers\_alerts\_cpu\_memory\_per\_series\_aligner) | n/a | `string` | `"ALIGN_MEAN"` | no |
| <a name="input_k8s_containers_alerts_cpu_memory_threshold_value"></a> [k8s\_containers\_alerts\_cpu\_memory\_threshold\_value](#input\_k8s\_containers\_alerts\_cpu\_memory\_threshold\_value) | n/a | `number` | `0.9` | no |
| <a name="input_k8s_containers_alerts_email_address"></a> [k8s\_containers\_alerts\_email\_address](#input\_k8s\_containers\_alerts\_email\_address) | n/a | `list(string)` | <pre>[<br>  "address@example.com"<br>]</pre> | no |
| <a name="input_k8s_containers_alerts_logs_alignment_period"></a> [k8s\_containers\_alerts\_logs\_alignment\_period](#input\_k8s\_containers\_alerts\_logs\_alignment\_period) | n/a | `string` | `"300s"` | no |
| <a name="input_k8s_containers_alerts_logs_duration"></a> [k8s\_containers\_alerts\_logs\_duration](#input\_k8s\_containers\_alerts\_logs\_duration) | Logs | `string` | `"300s"` | no |
| <a name="input_k8s_containers_alerts_logs_per_series_aligner"></a> [k8s\_containers\_alerts\_logs\_per\_series\_aligner](#input\_k8s\_containers\_alerts\_logs\_per\_series\_aligner) | n/a | `string` | `"ALIGN_SUM"` | no |
| <a name="input_k8s_containers_alerts_logs_threshold_value"></a> [k8s\_containers\_alerts\_logs\_threshold\_value](#input\_k8s\_containers\_alerts\_logs\_threshold\_value) | n/a | `number` | `0` | no |
| <a name="input_k8s_containers_alerts_pod_logs_alignment_period"></a> [k8s\_containers\_alerts\_pod\_logs\_alignment\_period](#input\_k8s\_containers\_alerts\_pod\_logs\_alignment\_period) | n/a | `string` | `"300s"` | no |
| <a name="input_k8s_containers_alerts_pod_logs_duration"></a> [k8s\_containers\_alerts\_pod\_logs\_duration](#input\_k8s\_containers\_alerts\_pod\_logs\_duration) | Pod warnings and errors | `string` | `"300s"` | no |
| <a name="input_k8s_containers_alerts_pod_logs_per_series_aligner"></a> [k8s\_containers\_alerts\_pod\_logs\_per\_series\_aligner](#input\_k8s\_containers\_alerts\_pod\_logs\_per\_series\_aligner) | n/a | `string` | `"ALIGN_SUM"` | no |
| <a name="input_k8s_containers_alerts_pod_logs_threshold_value"></a> [k8s\_containers\_alerts\_pod\_logs\_threshold\_value](#input\_k8s\_containers\_alerts\_pod\_logs\_threshold\_value) | n/a | `number` | `0` | no |
| <a name="input_k8s_containers_alerts_restarts_alignment_period"></a> [k8s\_containers\_alerts\_restarts\_alignment\_period](#input\_k8s\_containers\_alerts\_restarts\_alignment\_period) | n/a | `string` | `"300s"` | no |
| <a name="input_k8s_containers_alerts_restarts_duration"></a> [k8s\_containers\_alerts\_restarts\_duration](#input\_k8s\_containers\_alerts\_restarts\_duration) | Container restarts | `string` | `"60s"` | no |
| <a name="input_k8s_containers_alerts_restarts_per_series_aligner"></a> [k8s\_containers\_alerts\_restarts\_per\_series\_aligner](#input\_k8s\_containers\_alerts\_restarts\_per\_series\_aligner) | n/a | `string` | `"ALIGN_DELTA"` | no |
| <a name="input_k8s_containers_alerts_restarts_threshold_value"></a> [k8s\_containers\_alerts\_restarts\_threshold\_value](#input\_k8s\_containers\_alerts\_restarts\_threshold\_value) | n/a | `number` | `0` | no |
| <a name="input_k8s_containers_alerts_type"></a> [k8s\_containers\_alerts\_type](#input\_k8s\_containers\_alerts\_type) | ## slack or email supported only | `string` | `"slack"` | no |
| <a name="input_k8s_containers_namespaces"></a> [k8s\_containers\_namespaces](#input\_k8s\_containers\_namespaces) | n/a | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_k8s_namespaces"></a> [k8s\_namespaces](#input\_k8s\_namespaces) | List of namespaces to be created. | <pre>list(object({<br>    name          = string<br>    has_public_ip = optional(bool, false)<br>    regional_ip   = optional(bool, false)<br>    dns_records   = optional(set(string))<br>  }))</pre> | n/a | yes |
| <a name="input_k8s_workload_identity"></a> [k8s\_workload\_identity](#input\_k8s\_workload\_identity) | The workload pool to attach all Kubernetes service accounts to. (Default value of `enabled` automatically sets project-based pool `[project_id].svc.id.goog`) | `string` | `""` | no |
| <a name="input_project_admins"></a> [project\_admins](#input\_project\_admins) | List of project admins to be added. | `set(string)` | n/a | yes |
| <a name="input_project_editors"></a> [project\_editors](#input\_project\_editors) | List of project editors to be added. | `set(string)` | n/a | yes |
| <a name="input_project_viewers"></a> [project\_viewers](#input\_project\_viewers) | List of project viewers to be added. | `set(string)` | n/a | yes |
| <a name="input_sealed_secrets_enabled"></a> [sealed\_secrets\_enabled](#input\_sealed\_secrets\_enabled) | Enable the creation of sealed-secrets resources. | `bool` | `true` | no |
| <a name="input_slack_auth_token"></a> [slack\_auth\_token](#input\_slack\_auth\_token) | n/a | `string` | `"token"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cert_manager_service_key"></a> [cert\_manager\_service\_key](#output\_cert\_manager\_service\_key) | Service account key with the right permissions for DNS used by cert-manager. |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster Name |
| <a name="output_dns_name_servers"></a> [dns\_name\_servers](#output\_dns\_name\_servers) | List of the DNS servers. |
| <a name="output_flux_private_key_pem"></a> [flux\_private\_key\_pem](#output\_flux\_private\_key\_pem) | Private key to be used for github integration. |
| <a name="output_fluxv2_gcr_service_key"></a> [fluxv2\_gcr\_service\_key](#output\_fluxv2\_gcr\_service\_key) | Service account key with the right permissions for GCR  used by fluxv2. |
| <a name="output_fluxv2_private_key_pem"></a> [fluxv2\_private\_key\_pem](#output\_fluxv2\_private\_key\_pem) | Private key to be used for github integration. |
| <a name="output_fluxv2_public_key_pem"></a> [fluxv2\_public\_key\_pem](#output\_fluxv2\_public\_key\_pem) | Public key to be used for github integration. |
| <a name="output_gke_certificate"></a> [gke\_certificate](#output\_gke\_certificate) | Base64 encoded public certificate that is the root of trust for the cluster. |
| <a name="output_gke_cluster_id"></a> [gke\_cluster\_id](#output\_gke\_cluster\_id) | Cluster ID |
| <a name="output_gke_endpoint"></a> [gke\_endpoint](#output\_gke\_endpoint) | The IP address of this cluster's Kubernetes master. |
| <a name="output_gke_token"></a> [gke\_token](#output\_gke\_token) | GKE cluster token. |
| <a name="output_global_public_ips"></a> [global\_public\_ips](#output\_global\_public\_ips) | Map with global namespace-ip pairs |
| <a name="output_google_compute_network_vpc_id"></a> [google\_compute\_network\_vpc\_id](#output\_google\_compute\_network\_vpc\_id) | an identifier for the VPC resource with format projects/{{project}}/global/networks/{{name}} |
| <a name="output_google_compute_network_vpc_self_link"></a> [google\_compute\_network\_vpc\_self\_link](#output\_google\_compute\_network\_vpc\_self\_link) | The URI of the created VPC. |
| <a name="output_google_compute_subnetwork_id"></a> [google\_compute\_subnetwork\_id](#output\_google\_compute\_subnetwork\_id) | an identifier for the Subnet resource with format projects/{{project}}/regions/{{region}}/subnetworks/{{name}} |
| <a name="output_google_compute_subnetwork_name"></a> [google\_compute\_subnetwork\_name](#output\_google\_compute\_subnetwork\_name) | The name of the subnetwork |
| <a name="output_google_compute_subnetwork_region"></a> [google\_compute\_subnetwork\_region](#output\_google\_compute\_subnetwork\_region) | The GCP region for the subnetwork |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | Returns the project id. |
| <a name="output_project_number"></a> [project\_number](#output\_project\_number) | Returns the project number. |
| <a name="output_regional_public_ips"></a> [regional\_public\_ips](#output\_regional\_public\_ips) | Map with regional namespace-ip pairs |
| <a name="output_sealed_secrets_cert_pem"></a> [sealed\_secrets\_cert\_pem](#output\_sealed\_secrets\_cert\_pem) | Self-signed cert to be used for the encryption/decryption of secrets. |
| <a name="output_sealed_secrets_private_key"></a> [sealed\_secrets\_private\_key](#output\_sealed\_secrets\_private\_key) | Private key used for the encryption of secrets. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# Flux

Continuous delivery is a term that encapsulates a set of best practices that surround building, deploying and monitoring applications. The goal is to provide a sustainable model for maintaining and improving an application.

Flux is a tool that automates the deployment of containers to Kubernetes. It fills the automation void that exists between building and monitoring.

Flux’s main feature is the automated synchronisation between a version control repository and a cluster. If you make any changes to your repository, those changes are automatically deployed to your cluster.

More information about [`flux`].

# Sealed-secrets

Encrypt your Secret into a SealedSecret, which is safe to store - even to a public repository. The SealedSecret can be decrypted only by the controller running in the target cluster and nobody else (not even the original author) is able to obtain the original Secret from the SealedSecret.

The certificates are stored in sealedsecret-keys folder, every k8s cluster has its own certificate with which its decrypting the secrets. The secret has to be resealed in every environment for sealed-secret to be able to decrypt it.

More information about [`sealed-secrets`].

[`terraform`]: https://www.terraform.io
[`helm`]: https://helm.sh/
[`kubernetes`]: https://kubernetes.io/
[`sealed-secrets`]: https://github.com/bitnami-labs/sealed-secrets
[`flux`]: https://docs.fluxcd.io/en/1.18.0/introduction.html
