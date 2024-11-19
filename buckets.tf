locals {
  default_input_bucket_name  = lower("${var.installation_name}-${var.environment}-${var.name}-${var.country_code}-input")
  default_build_bucket_name  = lower("${var.installation_name}-${var.environment}-${var.name}-${var.country_code}-build")
  default_output_bucket_name = lower("${var.installation_name}-${var.environment}-${var.name}-${var.country_code}-output")
  input_bucket_name          = coalesce(var.input_bucket_name, local.default_input_bucket_name)
  build_bucket_name          = coalesce(var.build_bucket_name, local.default_build_bucket_name)
  output_bucket_name         = coalesce(var.output_bucket_name, local.default_output_bucket_name)
}

resource "google_storage_bucket" "tenant_build_bucket" {
  provider                    = google-beta
  depends_on                  = [google_kms_crypto_key.tenant_crypto_key, module.kms_crypto_key-iam-bindings]
  project                     = var.data_plane_project
  name                        = local.build_bucket_name
  location                    = var.storage_location
  uniform_bucket_level_access = true

  dynamic "encryption" {
    for_each = var.enable_kms ? [google_kms_crypto_key.tenant_crypto_key[0].id] : []
    content {
      default_kms_key_name = google_kms_crypto_key.tenant_crypto_key[0].id
    }
  }

  labels = {
    organisation-id = lower(var.organisation_id)
    tenant-name     = lower(var.name)
    country         = lower(var.country_code)
    part-of         = "identity-engine"
    layer           = "data-plane"
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

data "google_iam_policy" "tenant_build_bucket" {
  binding {
    role = "roles/storage.admin"
    members = [
      "projectOwner:${var.data_plane_project}"
    ]
  }
  binding {
    role = "roles/storage.objectUser"
    members = concat(
      local.prefixed_editor_list,
      [
        "serviceAccount:${google_service_account.tenant_data_access.email}",
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
        "serviceAccount:${google_service_account.tenant_data_access.email}"
      ]
    )
  }
}

resource "google_storage_bucket_iam_policy" "tenant_build_bucket" {
  bucket      = google_storage_bucket.tenant_build_bucket.name
  policy_data = data.google_iam_policy.tenant_build_bucket.policy_data
}

resource "google_storage_bucket" "tenant_output_bucket" {
  count                       = var.create_input_output_buckets ? 1 : 0
  provider                    = google-beta
  depends_on                  = [google_kms_crypto_key.tenant_crypto_key, module.kms_crypto_key-iam-bindings]
  project                     = var.data_plane_project
  name                        = local.output_bucket_name
  location                    = var.storage_location
  uniform_bucket_level_access = true

  dynamic "encryption" {
    for_each = var.enable_kms ? [google_kms_crypto_key.tenant_crypto_key[0].id] : []
    content {
      default_kms_key_name = google_kms_crypto_key.tenant_crypto_key[0].id
    }
  }

  labels = {
    organisation-id = lower(var.organisation_id)
    tenant-name     = lower(var.name)
    country         = lower(var.country_code)
    part-of         = "identity-engine"
    layer           = "data-plane"
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

data "google_iam_policy" "tenant_output_bucket" {
  binding {
    role = "roles/storage.admin"
    members = [
      "projectOwner:${var.data_plane_project}"
    ]
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
        "serviceAccount:${google_service_account.tenant_data_access.email}"
      ]
    )
  }
}

resource "google_storage_bucket_iam_policy" "tenant_output_bucket" {
  count       = var.create_input_output_buckets ? 1 : 0
  bucket      = google_storage_bucket.tenant_output_bucket.name
  policy_data = data.google_iam_policy.tenant_output_bucket.policy_data
}

resource "google_storage_bucket" "tenant_input_bucket" {
  count                       = var.create_input_output_buckets ? 1 : 0
  provider                    = google-beta
  depends_on                  = [google_kms_crypto_key.tenant_crypto_key, module.kms_crypto_key-iam-bindings]
  project                     = var.data_plane_project
  name                        = local.input_bucket_name
  location                    = var.storage_location
  uniform_bucket_level_access = true

  dynamic "encryption" {
    for_each = var.enable_kms ? [google_kms_crypto_key.tenant_crypto_key[0].id] : []
    content {
      default_kms_key_name = google_kms_crypto_key.tenant_crypto_key[0].id
    }
  }

  labels = {
    organisation-id = lower(var.organisation_id)
    tenant-name     = lower(var.name)
    country         = lower(var.country_code)
    part-of         = "identity-engine"
    layer           = "data-plane"
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

data "google_iam_policy" "tenant_input_bucket" {
  binding {
    role = "roles/storage.admin"
    members = [
      "projectOwner:${var.data_plane_project}"
    ]
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
        "serviceAccount:${google_service_account.tenant_data_access.email}"
      ]
    )
  }
}

resource "google_storage_bucket_iam_policy" "tenant_input_bucket" {
  count       = var.create_input_output_buckets ? 1 : 0
  bucket      = google_storage_bucket.tenant_input_bucket.name
  policy_data = data.google_iam_policy.tenant_input_bucket.policy_data
}
