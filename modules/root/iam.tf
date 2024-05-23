resource "google_project_iam_member" "serviceAccount_user" {
  project = var.data_plane_project
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.tenant_data_access.email}"
}

resource "google_project_iam_member" "dataproc_worker" {
  project = var.data_plane_project
  role    = "roles/dataproc.worker"
  member  = "serviceAccount:${google_service_account.tenant_data_access.email}"
}

resource "google_project_iam_member" "dataproc_editor" {
  project = var.data_plane_project
  role    = "roles/dataproc.editor"
  member  = "serviceAccount:${google_service_account.tenant_data_access.email}"
}

resource "google_project_iam_member" "bigquery_job_creator" {
  project = var.data_plane_project
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.tenant_data_access.email}"
}

resource "google_project_iam_member" "bigquery_job_user" {
  project = var.data_plane_project
  role    = "roles/bigquery.user"
  member  = "serviceAccount:${google_service_account.tenant_data_access.email}"
}

# Required for spark connector to push work down to BigQuery
resource "google_project_iam_member" "allow_bq_connector_push_down" {
  project = var.data_plane_project
  role    = "roles/bigquery.readSessionUser"
  member  = "serviceAccount:${google_service_account.tenant_data_access.email}"
}

resource "google_service_account_iam_member" "tenant_orchestration_impersonate_tenant_data_access_sa" {
  service_account_id = google_service_account.tenant_data_access.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${var.tenant_orchestration_sa}"
}
