resource "google_compute_network" "vpc_network" {
  count                   = (var.vpc_network_name == null || var.vpc_network_name == "") ? 1 : 0
  project                 = var.project_id
  name                    = lower("${var.installation_name}-${var.region}-vpc")
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  description             = "The shared network for the identity graph"
}

data "google_compute_network" "vpc_network" {
  project = var.project_id
  name    = (var.vpc_network_name == null || var.vpc_network_name == "") ? google_compute_network.vpc_network[0].name : var.vpc_network_name
}

module "root" {
  for_each = var.data_planes
  source   = "./modules/root"

  environment              = var.environment
  data_plane_project       = var.project_id
  gcp_region               = var.region
  installation_name        = var.installation_name
  storage_location         = each.value.storage_region
  key_management_location  = var.key_management_location
  dataproc_subnet_ip4_cidr = var.subnet_ip4_cidr

  organisation_id = each.value.organisation_id
  name            = each.value.tenant_name
  country_code    = each.value.country_code
  data_viewers    = each.value.data_viewers
  data_editors    = each.value.data_editors

  tenant_orchestration_sa    = each.value.tenant_orchestration_sa
  data_retention_period_days = each.value.data_retention_period_days
  key_rotation_period_days   = each.value.key_rotation_period_days

  metastore_cidr_ip_address = var.metastore_cidr_ip_address
  idapi_cidr_ip_addresses   = var.idapi_cidr_ip_addresses
}

module "network" {
    depends_on = [ module.root ]
    source                    = "./modules/network"
    installation_name         = var.installation_name
    project_id                = var.project_id
    region                    = var.region
    network_name              = data.google_compute_network.vpc_network.name
    subnet_ip4_cidr           = var.subnet_ip4_cidr
    subnet_users              = []
    idapi_cidr_ip_addresses   = var.idapi_cidr_ip_addresses
    metastore_cidr_ip_address = var.metastore_cidr_ip_address
}
