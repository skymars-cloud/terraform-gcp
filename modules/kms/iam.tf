// Invalid KeyRing id format, expecting `{projectId}/{locationId}/{keyRingName}` or `{locationId}/{keyRingName}.`

//module "kms_key_ring_iam_binding" {
//  source        = "git::https://github.com/terraform-google-modules/terraform-google-iam.git//modules/kms_key_rings_iam?ref=master"
//  kms_key_rings = var.kms_key_rings
//  mode          = "additive"
//
//  bindings = {
//    "roles/cloudkms.cryptoKeyEncrypter" = [
//      "serviceAccount:${var.sa_email}",
//      "user:${var.user_email}",
//      "group:${var.group_email}"
//    ]
//    "roles/cloudkms.cryptoKeyDecrypter" = [
//      "serviceAccount:${var.sa_email}",
//      "user:${var.user_email}",
//      "group:${var.group_email}"
//    ]
//  }
//}
//
//module "kms_crypto_key_iam_binding" {
//  source          = "git::https://github.com/terraform-google-modules/terraform-google-iam.git//modules/kms_crypto_keys_iam?ref=master"
//  kms_crypto_keys = var.kms_crypto_keys
//
//  mode = "authoritative"
//
//  bindings = {
//    "roles/cloudkms.cryptoKeyEncrypter" = [
//      "serviceAccount:${var.sa_email}",
//      "user:${var.user_email}",
//      "group:${var.group_email}"
//    ]
//    "roles/cloudkms.cryptoKeyDecrypter" = [
//      "serviceAccount:${var.sa_email}",
//      "user:${var.user_email}",
//      "group:${var.group_email}"
//    ]
//  }
//}
