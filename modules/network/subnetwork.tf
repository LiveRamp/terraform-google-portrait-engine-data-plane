resource "google_compute_subnetwork" "dataproc_subnet" {
  project                  = var.project_id
  region                   = var.region
  name                     = lower("${var.installation_name}-${var.region}-dataproc")
  ip_cidr_range            = var.subnet_ip4_cidr
  network                  = var.network_name
  private_ip_google_access = true
}