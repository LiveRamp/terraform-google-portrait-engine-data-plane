variable "installation_name" {
    type = string
}

variable "project_id" {
  type        = string
}

variable "region" {
  type        = string
}

variable "environment" {
  type        = string
  description = "The environment this infrastructure is supported (dev, staging or prod)"
}

variable "vpc_network_name" {
  type        = string
  description = "The network to connect the data-plane to, if not specified, module will provision a dedicated one"
  default     = null
}

variable "subnet_ip4_cidr" {
    type = string
}

variable "key_management_location" {
    type = string
}

variable "metastore_cidr_ip_address" {
  type        = string
  description = "Identity Engine Metastore CloudSQL instance CIDR IP address"
}

variable "idapi_cidr_ip_addresses" {
  type        = list(string)
  default     = []
  description = "Identity Engine ID-API instance CIDR IP addresses"
}

variable "data_planes" {
  type = map(object({
    tenant_name     = string
    organisation_id = string
    country_code    = string
    storage_region  = optional(string)
    data_editors = object({
      service_accounts = list(string)
      groups           = list(string)
      users            = list(string)
    })
    data_viewers = object({
      service_accounts = list(string)
      groups           = list(string)
      users            = list(string)
    })
    tenant_orchestration_sa    = string
    data_retention_period_days = number
    key_rotation_period_days   = number
  }))
  description = "A map of portrait engine data-planes with their customer specific configuration. Set storage_region to enable regional storage"
}
