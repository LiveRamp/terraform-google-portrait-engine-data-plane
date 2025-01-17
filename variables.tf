variable "organisation_id" {
  type        = string
  description = "Liveramp CAC/Organisation-id"
}

variable "installation_name" {
  type    = string
  default = "identity-engine"
}

variable "name" {
  type        = string
  description = "The human readable customer name"
}

variable "country_code" {
  type        = string
  description = "The ISO 3166-1 two character country code (https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes)"
}

variable "environment" {
  type        = string
  description = "The environment this infrastructure is supported (eg.: dev, staging or prod)"
}

variable "data_plane_project" {
  type        = string
  description = "The GCP project in which customer data will be stored."
}

variable "bigquery_location" {
  type        = string
  description = "The storage location for BigQuery."
}

variable "storage_location" {
  type        = string
  description = "The storage location for GCS."
}

variable "gcp_region" {
  type        = string
  description = "The GCP region to be used"
}

variable "dataproc_subnet_ip4_cidr" {
  type        = string
  description = "Subnet used for Dataproc clusters"
}

variable "key_management_location" {
  type        = string
  description = "The key management location for KMS"
}

variable "tenant_orchestration_sa" {
  type        = string
  description = "Tenant Orchestration ServiceAccount for remote execution"
}

variable "data_editors" {
  type = object({
    service_accounts = list(string)
    groups           = list(string)
    users            = list(string)
  })
  description = "The users, groups & service accounts that should have read & write access to this customers data"
}

variable "data_viewers" {
  type = object({
    service_accounts = list(string)
    groups           = list(string)
    users            = list(string)
  })
  description = "The users, groups & service accounts that should have read only access to this customers data"
}

variable "data_retention_period_days" {
  type        = number
  description = "The number of days this customers data will be stored before its automatically deleted"
  default     = 0
}

variable "key_rotation_period_days" {
  type        = number
  description = "The frequency at which the crypto key will automatically rotate (days)"
  default     = 90
}

variable "metastore_cidr_ip_address" {
  type        = string
  description = "Portrait Engine Metastore CloudSQL instance CIDR IP address"
}

variable "idapi_cidr_ip_addresses" {
  type        = list(string)
  default     = []
  description = "Portrait Engine ID-API instance CIDR IP addresses"
}

variable "enable_dataproc_network" {
  type        = bool
  description = "Configure network bits for Dataproc - VPC, firewall rules etc"
  default     = true
}

variable "enable_kms" {
  type        = bool
  description = "Configure KMS to encrypt build bucket"
  default     = true
}

variable "bigquery_dataset_name" {
  type        = string
  description = "BigQuery Dataset name"
  default     = ""
}

variable "build_bucket_name" {
  type        = string
  description = "GCS Build bucket name"
  default     = ""
}

variable "tenant_service_account_name" {
  type        = string
  description = "Service Account name"
  default     = ""
}
