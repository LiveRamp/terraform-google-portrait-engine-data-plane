## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_compute"></a> [compute](#provider\_compute) | n/a |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms_crypto_key-iam-bindings"></a> [kms\_crypto\_key-iam-bindings](#module\_kms\_crypto\_key-iam-bindings) | terraform-google-modules/iam/google//modules/kms_crypto_keys_iam | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_storage_bucket.tenant_build_bucket](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_storage_bucket) | resource |
| [google-beta_google_storage_bucket.tenant_input_bucket](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_storage_bucket) | resource |
| [google-beta_google_storage_bucket.tenant_output_bucket](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_storage_bucket) | resource |
| [google_bigquery_dataset.tenant_dataset](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset) | resource |
| [google_compute_network.vpc_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_kms_crypto_key.tenant_crypto_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_key_ring.kms](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_project_iam_member.allow_bq_connector_push_down](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.bigquery_job_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.bigquery_job_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.dataproc_editor](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.dataproc_worker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.serviceAccount_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.enable_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.tenant_data_access](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.tenant_orchestration_impersonate_tenant_data_access_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket_iam_policy.tenant_build_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_policy) | resource |
| [google_storage_bucket_iam_policy.tenant_input_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_policy) | resource |
| [google_storage_bucket_iam_policy.tenant_output_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_policy) | resource |
| [random_id.generator](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [compute_compute.vpc_network](https://registry.terraform.io/providers/hashicorp/compute/latest/docs/data-sources/compute) | data source |
| [google_iam_policy.tenant_build_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |
| [google_iam_policy.tenant_input_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |
| [google_iam_policy.tenant_output_bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |
| [google_project.data_plane_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |
| [google_storage_project_service_account.data_plane_gcs_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bigquery_dataset_name"></a> [bigquery\_dataset\_name](#input\_bigquery\_dataset\_name) | BigQuery Dataset name | `string` | `""` | no |
| <a name="input_build_bucket_name"></a> [build\_bucket\_name](#input\_build\_bucket\_name) | GCS Build bucket name | `string` | `""` | no |
| <a name="input_country_code"></a> [country\_code](#input\_country\_code) | The ISO 3166-1 two character country code (https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes) | `string` | n/a | yes |
| <a name="input_data_editors"></a> [data\_editors](#input\_data\_editors) | The users, groups & service accounts that should have read & write access to this customers data | <pre>object({<br>    service_accounts = list(string)<br>    groups           = list(string)<br>    users            = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_data_plane_project"></a> [data\_plane\_project](#input\_data\_plane\_project) | The GCP project in which customer data will be stored. | `string` | n/a | yes |
| <a name="input_data_retention_period_days"></a> [data\_retention\_period\_days](#input\_data\_retention\_period\_days) | The number of days this customers data will be stored before its automatically deleted | `number` | `0` | no |
| <a name="input_data_viewers"></a> [data\_viewers](#input\_data\_viewers) | The users, groups & service accounts that should have read only access to this customers data | <pre>object({<br>    service_accounts = list(string)<br>    groups           = list(string)<br>    users            = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_dataproc_subnet_ip4_cidr"></a> [dataproc\_subnet\_ip4\_cidr](#input\_dataproc\_subnet\_ip4\_cidr) | Subnet used for Dataproc clusters | `string` | n/a | yes |
| <a name="input_enable_kms"></a> [enable\_kms](#input\_enable\_kms) | Configure KMS to encrypt build, input and output buckets | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment this infrastructure is supported (eg.: dev, staging or prod) | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The GCP region to be used | `string` | n/a | yes |
| <a name="input_idapi_cidr_ip_addresses"></a> [idapi\_cidr\_ip\_addresses](#input\_idapi\_cidr\_ip\_addresses) | Portrait Engine ID-API instance CIDR IP addresses | `list(string)` | `[]` | no |
| <a name="input_input_bucket_name"></a> [input\_bucket\_name](#input\_input\_bucket\_name) | GCS Input bucket name | `string` | `""` | no |
| <a name="input_installation_name"></a> [installation\_name](#input\_installation\_name) | n/a | `string` | `"identity-engine"` | no |
| <a name="input_key_management_location"></a> [key\_management\_location](#input\_key\_management\_location) | The key management location for KMS | `string` | n/a | yes |
| <a name="input_key_rotation_period_days"></a> [key\_rotation\_period\_days](#input\_key\_rotation\_period\_days) | The frequency at which the crypto key will automatically rotate (days) | `number` | `90` | no |
| <a name="input_metastore_cidr_ip_address"></a> [metastore\_cidr\_ip\_address](#input\_metastore\_cidr\_ip\_address) | Portrait Engine Metastore CloudSQL instance CIDR IP address | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The human readable customer name | `string` | n/a | yes |
| <a name="input_organisation_id"></a> [organisation\_id](#input\_organisation\_id) | Liveramp CAC/Organisation-id | `string` | n/a | yes |
| <a name="input_output_bucket_name"></a> [output\_bucket\_name](#input\_output\_bucket\_name) | GCS Output bucket name | `string` | `""` | no |
| <a name="input_storage_location"></a> [storage\_location](#input\_storage\_location) | The storage location for BigQuery and GCS. | `string` | n/a | yes |
| <a name="input_tenant_orchestration_sa"></a> [tenant\_orchestration\_sa](#input\_tenant\_orchestration\_sa) | Tenant Orchestration ServiceAccount for remote execution | `string` | n/a | yes |
| <a name="input_tenant_service_account_name"></a> [tenant\_service\_account\_name](#input\_tenant\_service\_account\_name) | Service Account name | `string` | `""` | no |
| <a name="input_vpc_network_name"></a> [vpc\_network\_name](#input\_vpc\_network\_name) | The network to connect the data-plane to, if not specified, module will provision a dedicated one | `bool` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_build_bucket_name"></a> [build\_bucket\_name](#output\_build\_bucket\_name) | The name of the GCS bucket that will be used to store the build files |
| <a name="output_input_bucket_name"></a> [input\_bucket\_name](#output\_input\_bucket\_name) | The name of the GCS bucket that will be used to store the input files |
| <a name="output_output_bucket_name"></a> [output\_bucket\_name](#output\_output\_bucket\_name) | The name of the GCS bucket that will be used to store the output files |
| <a name="output_tenant_bigquery_dataset_name"></a> [tenant\_bigquery\_dataset\_name](#output\_tenant\_bigquery\_dataset\_name) | The name of the BigQuery dataset that will be used to store the tenant data |
| <a name="output_tenant_data_access_svc_account"></a> [tenant\_data\_access\_svc\_account](#output\_tenant\_data\_access\_svc\_account) | The service account object that will be used to access the tenant data |
| <a name="output_vpc_network_name"></a> [vpc\_network\_name](#output\_vpc\_network\_name) | The name of the VPC network |
