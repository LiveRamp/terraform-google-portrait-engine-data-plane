resource "google_compute_address" "cloud_nat_static_ip_address" {
  count   = 2
  project = var.project_id
  region  = var.region
  name    = lower("${var.installation_name}-${var.region}-nat-ip-${count.index}")
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 6.0"
  name    = lower("${var.installation_name}-${var.region}-router")
  project = var.project_id
  network = var.network_name
  region  = var.region

  nats = [{
    name                               = lower("${var.installation_name}-${var.region}-nat")
    nat_ip_allocate_option             = "MANUAL_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    nat_ips                            = google_compute_address.cloud_nat_static_ip_address.*.self_link
    min_ports_per_vm                   = 256 # Increased from default of 64
    tcp_established_idle_timeout_sec   = 300 # Decreased from default of 1200s
    tcp_transitory_idle_timeout_sec    = 180 # Increased from default of 30s

    log_config = {
      enable = true
      filter = "ERRORS_ONLY"
    }
  }]
}
