locals {
  prefixed_dataproc_service_agent_mail = "serviceAccount:service-${data.google_project.data_plane_project.number}@dataproc-accounts.iam.gserviceaccount.com"

  # BigQuery encryption service account for use with KMS
  prefixed_big_query_kms_user = "serviceAccount:bq-${data.google_project.data_plane_project.number}@bigquery-encryption.iam.gserviceaccount.com"

  # Create list of all reader users, service accounts and groups with their associated prefix
  prefixed_reader_list = concat(
    [for i in var.data_viewers.groups : "group:${i}"],
    [for i in var.data_viewers.service_accounts : "serviceAccount:${i}"],
    [for i in var.data_viewers.users : "user:${i}"]
  )

  # Create list of all reader users, service accounts and groups with their associated prefix
  prefixed_editor_list = concat(
    [for i in var.data_editors.groups : "group:${i}"],
    [for i in var.data_editors.service_accounts : "serviceAccount:${i}"],
    [for i in var.data_editors.users : "user:${i}"]
  )
}
