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
  can_ip_forward = false //CIS Benchmark v1.2 - 4.6 - gcp_compute_instance_ip_forward_v1.yaml
  network_interface {
    subnetwork = data.google_compute_subnetwork.subnetwork.name
    access_config { //  CIS Benchmark v1.2 - 4.9 - gcp_compute_forbid_external_ip_access_v1.yaml
      // Ephemeral IP                             //  CIS Benchmark v1.2 - 4.9 - gcp_compute_forbid_external_ip_access_v1.yaml
    } //  CIS Benchmark v1.2 - 4.9 - gcp_compute_forbid_external_ip_access_v1.yaml
  }

  metadata = {
    name                   = var.name
    environment            = var.environment
    block-project-ssh-keys = true  //  CIS Benchmark v1.2 - 4.3 - gcp_compute_instance_block_ssh_keys_v1.yaml
    enable-oslogin         = false //  CIS Benchmark v1.2 - 4.4 - gcp_compute_enable_oslogin_project_v1.yaml
    serial-port-enable     = false //  CIS Benchmark v1.2 - 4.5 - gcp_compute_instance_serial_port_enable_v1.yaml
  }

  metadata_startup_script = "echo instance created through terraform > /readme.txt"

  service_account { //  CIS Benchmark v1.2 - 4.1 & 4.2 - gcp_compute_default_service_account_v1.yaml
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.owner.email
    scopes = ["cloud-platform"]
  }
  shielded_instance_config {
    enable_integrity_monitoring = true // CIS Benchmark v1.2 - 4.8 - gcp_compute_instance_shielded_v1.yaml
    enable_vtpm                 = true // CIS Benchmark v1.2 - 4.8 - gcp_compute_instance_shielded_v1.yaml
  }
}