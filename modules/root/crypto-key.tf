locals {

  crypto_key_users = concat(
    local.prefixed_reader_list,
    local.prefixed_editor_list,
    [
      local.prefixed_dataproc_service_agent_mail,
      local.prefixed_big_query_kms_user,
      "serviceAccount:${data.google_storage_project_service_account.data_plane_gcs_account.email_address}",
    ]
  )

  crypto_key_users_as_map = {
    for index, value in local.crypto_key_users :
    index => value
  }

}

resource "google_kms_key_ring" "kms" {
  count    = var.enable_kms ? 1 : 0
  project  = var.data_plane_project
  name     = lower("${var.installation_name}-${var.name}-${var.country_code}-kms")
  location = var.key_management_location
}

resource "google_kms_crypto_key" "tenant_crypto_key" {
  count           = var.enable_kms ? 1 : 0
  name            = lower("${var.installation_name}-${var.name}-${var.country_code}-key")
  key_ring        = google_kms_key_ring.kms[count.index].id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "${var.key_rotation_period_days * 86400}s"
}

module "kms_crypto_key-iam-bindings" {
  source          = "terraform-google-modules/iam/google//modules/kms_crypto_keys_iam"
  count           = var.enable_kms ? 1 : 0
  kms_crypto_keys = [google_kms_crypto_key.tenant_crypto_key[count.index].id]

  mode = "additive"

  bindings = {
    "roles/cloudkms.cryptoKeyEncrypterDecrypter" = concat(
      local.prefixed_reader_list,
      local.prefixed_editor_list,
      [
        local.prefixed_dataproc_service_agent_mail,
        local.prefixed_big_query_kms_user,
        "serviceAccount:${data.google_storage_project_service_account.data_plane_gcs_account.email_address}",
      ]
    )
  }
}
