resource "google_compute_disk" "disk-1" {
  name                      = "disk-1"
  type                      = "pd-standard"
  project                   = var.project_id
  zone                      = var.primary_zone
  size                      = "500"
  physical_block_size_bytes = 4096
  image                     = "centos-8-v20210512"
  labels = {
    critical_vm = true,
    name        = "pals-critical-disk"
  }
  disk_encryption_key {
    kms_key_self_link       = "projects/prj-dev-palani-ram/locations/global/keyRings/kms-keyring-dev/cryptoKeys/kms-key-dev"
    kms_key_service_account = var.service_account_email
  }

}

resource "google_compute_disk_iam_binding" "binding" {
  project = var.project_id
  zone    = var.primary_zone
  name    = google_compute_disk.disk-1.name
  role    = "roles/editor"
  members = [
    "serviceAccount:${var.service_account_email}"
  ]
}