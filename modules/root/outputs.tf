output "tenant_data_access_svc_account" {
  value       = google_service_account.tenant_data_access
  description = "The service account object that will be used to access the tenant data"
}

output "tenant_bigquery_dataset_name" {
  value       = google_bigquery_dataset.tenant_dataset.dataset_id
  description = "The name of the BigQuery dataset that will be used to store the tenant data"
}

output "input_bucket_name" {
  value       = google_storage_bucket.tenant_input_bucket.name
  description = "The name of the GCS bucket that will be used to store the input files"
}

output "build_bucket_name" {
  value       = google_storage_bucket.tenant_build_bucket.name
  description = "The name of the GCS bucket that will be used to store the build files"
}

output "output_bucket_name" {
  value       = google_storage_bucket.tenant_output_bucket.name
  description = "The name of the GCS bucket that will be used to store the output files"
}
