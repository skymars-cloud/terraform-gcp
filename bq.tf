data "google_kms_key_ring" "dev_key_ring" {
  name     = "kms-keyring-dev"
  location = var.primary_region
}

data "google_kms_crypto_key" "dev_crypto_key" {
  name     = "kms-key-dev"
  key_ring = "${var.project_id_dev}/${module.kms_key.location}/${module.kms_key.keyring}"
}

data "google_kms_crypto_key_version" "dev_crypto_key" {
  crypto_key = "${var.project_id_dev}/${module.kms_key.location}/${module.kms_key.keyring}/kms-key-dev"
}

module "bq" {
  count      = var.enable_bq_module ? 1 : 0
  source     = "./modules/bigquery"
  project_id = var.project_id_dev
  kms_key    = data.google_kms_crypto_key_version.dev_crypto_key.crypto_key
}
