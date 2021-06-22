
locals {
  kms_crypto_keyring = "kms-keyring-dev"
  kms_crypto_key     = "kms-key-dev"
}

data "google_kms_key_ring" "kms-keyring-dev" {
  name = local.kms_crypto_keyring
  // A full list of valid locations can be found by running
  // gcloud kms locations list | grep LOCATION_ID | more
  location = "global"
}

data "google_kms_crypto_key" "kms-key-dev" {
  name = local.kms_crypto_key
  //  key_ring = local.kms_crypto_keyring // Invalid KeyRing id format, expecting `{projectId}/{locationId}/{keyRingName}` or `{locationId}/{keyRingName}.`
  key_ring = data.google_kms_key_ring.kms-keyring-dev.self_link
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/editor"
    members = [
      "allUsers", "allAuthenticatedUsers"
    ]
  }
}

module "kms_key" {
  source          = "./modules/kms"
  keyring         = local.kms_crypto_keyring
  project_id      = var.project_id_dev
  kms_crypto_keys = [local.kms_crypto_key]
  kms_key_rings   = [local.kms_crypto_keyring]
  group_email     = var.gsuite_user_email_id
  sa_email        = var.service_account_email
  user_email      = var.gsuite_user_email_id
  keys            = [local.kms_crypto_key]

}

resource "google_kms_key_ring_iam_policy" "key_ring" {
  key_ring_id = data.google_kms_key_ring.kms-keyring-dev.id
  policy_data = data.google_iam_policy.admin.policy_data
}

resource "google_kms_crypto_key_iam_policy" "crypto_key" {
  crypto_key_id = data.google_kms_crypto_key.kms-key-dev.id
  policy_data   = data.google_iam_policy.admin.policy_data
}

resource "google_kms_key_ring_iam_binding" "key_ring" {
  key_ring_id = data.google_kms_key_ring.kms-keyring-dev.id
  role        = "roles/cloudkms.cryptoKeyEncrypter"

  members = [
    "allUsers", "allAuthenticatedUsers"
  ]
}

resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = data.google_kms_crypto_key.kms-key-dev.id
  role          = "roles/cloudkms.admin"

  members = [
    "allAuthenticatedUsers", "allUsers"
  ]
  depends_on = []
}

resource "google_kms_key_ring_iam_member" "key_ring" {
  key_ring_id = data.google_kms_key_ring.kms-keyring-dev.id
  role        = "roles/viewers"
  member      = "allAuthenticatedUsers"
}

resource "google_kms_crypto_key_iam_member" "crypto_key" {
  crypto_key_id = data.google_kms_crypto_key.kms-key-dev.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "allUsers"
}



