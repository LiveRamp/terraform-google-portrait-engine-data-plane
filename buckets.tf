locals {
  input_bucket  = lower("${var.installation_name}-${var.environment}-${var.name}-${var.country_code}-input")
  build_bucket  = lower("${var.installation_name}-${var.environment}-${var.name}-${var.country_code}-build")
  output_bucket = lower("${var.installation_name}-${var.environment}-${var.name}-${var.country_code}-output")
}

resource "google_storage_bucket" "customer_build_bucket" {
  depends_on                  = [google_kms_crypto_key.customer_crypto_key, google_kms_crypto_key_iam_member.key_user]
  project                     = var.data_plane_project
  name                        = local.build_bucket
  location                    = var.storage_location
  uniform_bucket_level_access = true
  encryption {
    default_kms_key_name = google_kms_crypto_key.customer_crypto_key.id
  }
  labels = {
    organisation-id = lower(var.organisation_id)
    tenant-name     = lower(var.name)
    country         = lower(var.country_code)
    component       = "data-plane"
    part-of         = "portrait-engine"
    installation    = var.installation_name
  }
  lifecycle_rule {
    condition {
      age = var.data_retention_period_days
    }
    action {
      type = "Delete"
    }
  }
  versioning {
    enabled = false
  }
}

data "google_iam_policy" "customer_build_bucket" {
  binding {
    role = "roles/storage.admin"
    # Do not add people to this group its basically admin for everything and they could delete the bucket
    # bucket changes should go through atlantis and be reviewed.
    members = [
      "projectOwner:${var.data_plane_project}"
    ]
  }
  # Write permission to this bucket
  binding {
    role = "roles/storage.objectAdmin"
    members = concat(
      local.prefixed_editor_list,
      [
        "serviceAccount:${google_service_account.tenant_orchestration_service_account.email}",
      ]
    )
  }
  binding {
    role = "roles/storage.objectViewer"
    members = concat(
      local.prefixed_reader_list,
      [local.prefixed_dataproc_service_agent_mail]
    )
  }
  binding {
    role = "roles/storage.legacyBucketReader"
    members = concat(
      local.prefixed_editor_list,
      local.prefixed_reader_list,
      [
        local.prefixed_dataproc_service_agent_mail,
        "serviceAccount:${google_service_account.tenant_orchestration_service_account.email}"
      ]
    )
  }
}

resource "google_storage_bucket_iam_policy" "customer_build_bucket" {
  bucket      = google_storage_bucket.customer_build_bucket.name
  policy_data = data.google_iam_policy.customer_build_bucket.policy_data
}

resource "google_storage_bucket" "customer_output_bucket" {
  depends_on                  = [google_kms_crypto_key.customer_crypto_key, google_kms_crypto_key_iam_member.key_user]
  project                     = var.data_plane_project
  name                        = local.output_bucket
  location                    = var.storage_location
  uniform_bucket_level_access = true
  encryption {
    default_kms_key_name = google_kms_crypto_key.customer_crypto_key.id
  }
  labels = {
    organisation-id = lower(var.organisation_id)
    tenant-name     = lower(var.name)
    country         = lower(var.country_code)
    component       = "data-plane"
    part-of         = "portrait-engine"
    installation    = var.installation_name
  }
  lifecycle_rule {
    condition {
      age = var.data_retention_period_days
    }
    action {
      type = "Delete"
    }
  }
  versioning {
    enabled = false
  }
}

data "google_iam_policy" "customer_output_bucket" {
  binding {
    role = "roles/storage.admin"
    # Do not add people to this group its basically admin for everything and they could delete the bucket
    # bucket changes should go through atlantis and be reviewed.
    members = [
      "projectOwner:${var.data_plane_project}"
    ]
  }
  # Write permission to this bucket
  binding {
    role = "roles/storage.objectAdmin"
    members = concat(
      local.prefixed_editor_list,
      [
        "serviceAccount:${google_service_account.tenant_orchestration_service_account.email}",
      ]
    )
  }
  binding {
    role = "roles/storage.objectViewer"
    members = concat(
      local.prefixed_reader_list,
      [local.prefixed_dataproc_service_agent_mail]
    )
  }
  binding {
    role = "roles/storage.legacyBucketReader"
    members = concat(
      local.prefixed_editor_list,
      local.prefixed_reader_list,
      [
        local.prefixed_dataproc_service_agent_mail,
        "serviceAccount:${google_service_account.tenant_orchestration_service_account.email}"
      ]
    )
  }
}

resource "google_storage_bucket_iam_policy" "customer_output_bucket" {
  bucket      = google_storage_bucket.customer_output_bucket.name
  policy_data = data.google_iam_policy.customer_output_bucket.policy_data
}

resource "google_storage_bucket" "customer_input_bucket" {
  depends_on                  = [google_kms_crypto_key.customer_crypto_key, google_kms_crypto_key_iam_member.key_user]
  project                     = var.data_plane_project
  name                        = local.input_bucket
  location                    = var.storage_location
  uniform_bucket_level_access = true
  encryption {
    default_kms_key_name = google_kms_crypto_key.customer_crypto_key.id
  }
  labels = {
    organisation-id = lower(var.organisation_id)
    tenant-name     = lower(var.name)
    country         = lower(var.country_code)
    component       = "data-plane"
    part-of         = "portrait-engine"
    installation    = var.installation_name
  }
  lifecycle_rule {
    condition {
      age = var.data_retention_period_days
    }
    action {
      type = "Delete"
    }
  }
  versioning {
    enabled = false
  }
}

data "google_iam_policy" "customer_input_bucket" {
  binding {
    role = "roles/storage.admin"
    # Do not add people to this group its basically admin for everything and they could delete the bucket
    # bucket changes should go through atlantis and be reviewed.
    members = [
      "projectOwner:${var.data_plane_project}"
    ]
  }
  # Write permission to this bucket
  binding {
    role = "roles/storage.objectAdmin"
    members = concat(
      local.prefixed_editor_list,
      [
        "serviceAccount:${google_service_account.tenant_orchestration_service_account.email}",
      ]
    )
  }
  binding {
    role = "roles/storage.objectViewer"
    members = concat(
      local.prefixed_reader_list,
      [local.prefixed_dataproc_service_agent_mail]
    )
  }
  binding {
    role = "roles/storage.legacyBucketReader"
    members = concat(
      local.prefixed_editor_list,
      local.prefixed_reader_list,
      [
        local.prefixed_dataproc_service_agent_mail,
        "serviceAccount:${google_service_account.tenant_orchestration_service_account.email}"
      ]
    )
  }
  binding {
    role = "roles/storage.objectCreator"
    members = [
      local.prefixed_ingestion_service_account_email
    ]
  }
  binding {
    role = "roles/storage.legacyBucketWriter"
    members = [
      local.prefixed_ingestion_service_account_email
    ]
  }
}

resource "google_storage_bucket_iam_policy" "customer_input_bucket" {
  bucket      = google_storage_bucket.customer_input_bucket.name
  policy_data = data.google_iam_policy.customer_input_bucket.policy_data
}
