provider "google" {
  version = "~> 3.67.0"
  region  = var.region
}

data "google_client_config" "default" {}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.subnetwork
  project = var.project_id
  region  = var.region
}

module "gke" {
  //  source = "../../modules/private-cluster"
  source            = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version           = "14.3.0"
  ip_range_pods     = var.ip_range_pods
  ip_range_services = var.ip_range_services
  name              = "stub-domains-private-cluster${var.cluster_name_suffix}"
  network           = var.network
  project_id        = var.project_id
  region            = var.region
  subnetwork        = var.subnetwork

  deploy_using_private_endpoint = true
  enable_private_endpoint       = false
  enable_private_nodes          = true

  master_authorized_networks = [
    {
      cidr_block   = data.google_compute_subnetwork.subnetwork.ip_cidr_range
      display_name = "VPC"
    },
  ]

  master_ipv4_cidr_block = "172.16.0.0/28"

  create_service_account = false
  service_account        = var.compute_engine_service_account

  stub_domains = {
    "example.com" = [
      "10.254.154.11",
      "10.254.154.12",
    ]
    "example.net" = [
      "10.254.154.11",
      "10.254.154.12",
    ]
  }
}