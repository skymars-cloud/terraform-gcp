data "google_service_account" "owner" {
  account_id = var.service_account_id
}
data "google_compute_image" "my_image" {
  family  = "debian-9"
  project = "debian-cloud"
}

resource "google_compute_instance" "default" {
  count        = var.create_compute_instance ? 1 : 0
  name         = var.name
  machine_type = var.machine_type
  zone         = var.primary_zone

  tags = [var.environment, var.name]

  boot_disk {
    initialize_params {
      image = "centos-8-v20210420"
      type  = "pd-standard"
      size  = 20
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    name        = var.name
    environment = var.environment
  }

  metadata_startup_script = "echo instance created through terraform > /readme.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.owner.email
    scopes = ["cloud-platform"]
  }
}