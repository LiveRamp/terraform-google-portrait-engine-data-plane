data "google_project" "data_plane_project" {
  project_id = var.data_plane_project
}

data "google_storage_project_service_account" "data_plane_gcs_account" {
  project = var.data_plane_project
}

resource "google_project_service" "enable_api" {
  for_each = toset([
    "accesscontextmanager.googleapis.com",
    "cloudkms.googleapis.com",
    "dataproc.googleapis.com",
    "pubsub.googleapis.com"
  ])
  project = var.data_plane_project
  service = each.value

  disable_on_destroy = false
}
