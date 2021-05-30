module "firewall_rules" {
  // https://github.com/terraform-google-modules/terraform-google-network/tree/release-v3.2.2/modules/firewall-rules
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = var.vpc_name

  rules = [
    {
      name                    = "allow-ssh-ingress"
      description             = "allow-ssh-ingress"
      direction               = "INGRESS"
      priority                = null
      ranges                  = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["ingress-inet"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    }
  ]

  depends_on = [module.network]
}

resource "google_compute_firewall" "allow_all_ingress" {
  name    = "allow-all-ingress-firewall"
  network = module.network.network_name
  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }

  source_tags = ["ingress-all"]
  direction   = "INGRESS"
}


resource "google_compute_firewall" "allow_all_egress" {
  name    = "allow-all-egress-firewall"
  network = module.network.network_name
  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }
  target_tags = ["egress-all"]
  direction   = "EGRESS"
}