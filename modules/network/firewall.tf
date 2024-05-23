resource "google_compute_firewall" "allow_metastore_egress" {
  project     = var.project_id
  name        = "allow-${var.installation_name}-metastore-egress"
  network     = var.network_name
  direction   = "EGRESS"
  priority    = "1000"
  description = "Allow EGRESS to Identity Engine Metastore CloudSQL instance"

  allow {
    protocol = "tcp"

    ports = [
      "3306"
    ]
  }
  destination_ranges = [var.metastore_cidr_ip_address]
}


resource "google_compute_firewall" "allow_idapi_egress" {
  project     = var.project_id
  name        = "allow-${var.installation_name}-idapi-egress"
  network     = var.network_name
  direction   = "EGRESS"
  priority    = "1000"
  description = "Allow EGRESS to LiveRamp ID-API instance"

  allow {
    protocol = "tcp"

    ports = [
      "443"
    ]
  }
  destination_ranges = var.idapi_cidr_ip_addresses
}


module "dataproc-firewall-rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version      = "6.0.1"
  project_id   = var.project_id
  network_name = var.network_name

  rules = [
    {
      name                    = "${var.installation_name}-dataproc-allow-ingress-from-subnet"
      description             = "Allow Dataproc clusters to communicate over private IP to google APIs and other nodes"
      direction               = "INGRESS"
      priority                = 1000
      ranges                  = [var.subnet_ip4_cidr]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [
        {
          protocol = "tcp"
          ports    = ["0-65535"]
        },
        {
          protocol = "udp"
          ports    = ["0-65535"]
        },
        {
          protocol = "icmp"
          ports    = []
        },
      ]
      deny       = []
      log_config = null
    },
    {
      name                    = "${var.installation_name}-dataproc-allow-egress-to-subnet"
      description             = "Allow Dataproc clusters to communicate over private IP to google APIs and other nodes"
      direction               = "EGRESS"
      priority                = 1000
      ranges                  = [var.subnet_ip4_cidr]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [
        {
          protocol = "tcp"
          ports    = ["0-65535"]
        },
        {
          protocol = "udp"
          ports    = ["0-65535"]
        },
        {
          protocol = "icmp"
          ports    = []
        },
      ]
      deny       = []
      log_config = null
    }
  ]
}
