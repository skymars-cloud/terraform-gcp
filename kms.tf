
locals {
  kms_crypto_keyring = "kms-keyring-dev"
  kms_crypto_key     = "kms-key-dev"
  kms_location       = "global"
}

data "google_kms_key_ring" "kms-keyring-dev" {
  name = local.kms_crypto_keyring
  // A full list of valid locations can be found by running
  // gcloud kms locations list | grep LOCATION_ID | more
  location = local.kms_location
}

data "google_kms_crypto_key" "kms-key-dev" {
  name     = local.kms_crypto_key
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
  key_rotation_period = "99999999s"
  //key_rotation_period = "7776000s"
}

// kms keyring iam
resource "google_kms_key_ring_iam_binding" "key_ring_iam_binding" {
  // key_ring_id format {project_id}/{location_name}/{key_ring_name} or {location_name}/{key_ring_name}
  key_ring_id = "${var.project_id_dev}/${local.kms_location}/${local.kms_crypto_keyring}"
  role        = "roles/cloudkms.admin"
  members = [
    "user:${var.gsuite_user_email_id}"
  ]
}

resource "google_kms_key_ring_iam_member" "key_ring_iam_member" {
  // key_ring_id format {project_id}/{location_name}/{key_ring_name} or {location_name}/{key_ring_name}
  key_ring_id = "${local.kms_location}/${local.kms_crypto_keyring}"
  role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member      = "user:${var.gsuite_user_email_id}"
}

// kms key iam
resource "google_kms_crypto_key_iam_binding" "crypto_key_binding" {
  crypto_key_id = data.google_kms_crypto_key.kms-key-dev.id
  role          = "roles/cloudkms.admin"

  members = [
    "allAuthenticatedUsers", "allUsers",
    "user:${var.gsuite_user_email_id}"
  ]
  depends_on = []
}

resource "google_kms_crypto_key_iam_member" "crypto_key_member" {
  crypto_key_id = data.google_kms_crypto_key.kms-key-dev.id
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  member        = "user:${var.gsuite_user_email_id}"
}

//resource "google_kms_key_ring_import_job" "import-job" {
//  key_ring = data.google_kms_key_ring.kms-keyring-dev.id
//  import_job_id = "kms-import-job"
//
//  import_method = "RSA_OAEP_4096_SHA1_AES_256"
//  protection_level = "SOFTWARE"
//}

// google_kms_crypto_key_iam_policy cannot be used in conjunction with
// google_kms_crypto_key_iam_binding and google_kms_crypto_key_iam_member
// or they will fight over what your policy should be.

//data "google_iam_policy" "admin" {
//  binding {
//    role = "roles/cloudkms.admin"
//    members = [
//      "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com", "allAuthenticatedUsers"
//    ]
//  }
//}
//
//resource "google_kms_key_ring_iam_policy" "key_ring_iam_policy" {
//  key_ring_id = data.google_kms_key_ring.kms-keyring-dev.id
//  policy_data = data.google_iam_policy.admin.policy_data
//}
//
//resource "google_kms_crypto_key_iam_policy" "crypto_key_iam_policy" {
//  crypto_key_id = data.google_kms_crypto_key.kms-key-dev.id
//  policy_data   = data.google_iam_policy.admin.policy_data
//}
