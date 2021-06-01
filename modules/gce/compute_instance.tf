data "google_service_account" "owner" {
  account_id = var.service_account_id
}

data "google_compute_image" "debian" {
  family  = "debian-9"
  project = "debian-cloud"
}

data "google_compute_network" "network" {
  name = var.vpc_name
}

data "google_compute_subnetwork" "subnetwork" {
  name   = var.subnet
  region = var.region
}

resource "google_compute_instance" "vm" {
  count        = var.create_compute_instance ? 1 : 0
  name         = var.name
  machine_type = var.machine_type
  zone         = var.primary_zone
  tags         = ["ingress-inet", "egress-inet"]

  boot_disk {
    initialize_params {
      image = "centos-8-v20210512"
      type  = "pd-standard"
      size  = 20
    }
  }

  network_interface {
    subnetwork = data.google_compute_subnetwork.subnetwork.name
    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    name                   = var.name
    environment            = var.environment
    block-project-ssh-keys = true
  }

  metadata_startup_script = "echo instance created through terraform > /readme.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.owner.email
    scopes = ["cloud-platform"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }
}