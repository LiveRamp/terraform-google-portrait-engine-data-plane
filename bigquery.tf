resource "google_bigquery_dataset" "tenant_dataset" {
  project       = var.data_plane_project
  dataset_id    = replace(lower("${var.installation_name}_${var.name}_${var.country_code}"), "-", "_")
  friendly_name = "${title(var.name)} ${upper(var.country_code)} dataset"
  description   = "This dataset is for ${title(var.name)} ${upper(var.country_code)}"
  location      = var.storage_location

  dynamic "default_encryption_configuration" {
    for_each = var.enable_kms ? [google_kms_crypto_key.tenant_crypto_key[0].id] : []
    content {
      kms_key_name = google_kms_crypto_key.tenant_crypto_key[0].id
    }
  }

  default_partition_expiration_ms = var.data_retention_period_days * 86400000

  labels = {
    organisation-id = lower(var.organisation_id)
    tenant-name     = lower(var.name)
    country         = lower(var.country_code)
  }

  access {
    role          = "OWNER"
    special_group = "projectOwners"
  }

  dynamic "access" {
    for_each = toset(concat(
      [google_service_account.tenant_data_access.email],
      var.data_editors.users,
      var.data_editors.service_accounts
    ))
    content {
      role          = "WRITER"
      user_by_email = access.value
    }
  }

  dynamic "access" {
    for_each = toset(var.data_editors.groups)
    content {
      role           = "WRITER"
      group_by_email = access.value
    }
  }

  dynamic "access" {
    for_each = toset(concat(
      var.data_viewers.users,
      var.data_viewers.service_accounts
    ))
    content {
      role          = "READER"
      user_by_email = access.value
    }
  }

  dynamic "access" {
    for_each = toset(var.data_viewers.groups)
    content {
      role           = "READER"
      group_by_email = access.value
    }
  }

  depends_on = [
    google_kms_crypto_key.tenant_crypto_key, module.kms_crypto_key-iam-bindings
  ]
}
