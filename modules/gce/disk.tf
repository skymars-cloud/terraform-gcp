resource "google_compute_disk" "disk-1" {
  name                      = "disk-1"
  type                      = "pd-standard"
  project                   = var.project_id
  zone                      = var.primary_zone
  size                      = "500"
  physical_block_size_bytes = 4096
  //Error: googleapi: Error 404: The resource 'projects/prj-dev-palani-ram/zones/us-central1-f/disks/disk-1' was not found

  disk_encryption_key {
    ////    sha256 = "N9jtnSxrBQd8AXpLfck5d5Yv5e1CN5LGeI4AiRqV1kg="
    ////    sha256 = "projects/prj-dev-palani-ram/locations/global/keyRings/kms-keyring-dev/cryptoKeys/kms-key-dev/cryptoKeyVersions/1"
    ////    sha256 = ""
  }
}