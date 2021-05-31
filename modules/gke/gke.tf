
locals {
  cluster_type = "simple-regional-private"
}

data "google_client_config" "default" {

}

//provider "kubernetes" {
//  host                   = "https://${module.gke.endpoint}"
//  token                  = data.google_client_config.default.access_token
//  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
//}

//data "google_compute_subnetwork" "subnetwork" {
//  name    = var.subnetwork
//  project = var.project_id
//  region  = var.region
//}

module "gke" {
  source                 = "git::https://github.com/terraform-google-modules/terraform-google-kubernetes-engine.git//modules/private-cluster?ref=master"
  project_id             = var.project_id
  name                   = "${local.cluster_type}-cluster${var.cluster_name_suffix}"
  regional               = true
  region                 = var.region
  network                = var.network
  subnetwork             = var.subnetwork
  ip_range_pods          = var.ip_range_pods
  ip_range_services      = var.ip_range_services
  create_service_account = false
  service_account        = var.compute_engine_service_account
  //  enable_private_endpoint   = true
  enable_private_nodes = true
  //  master_ipv4_cidr_block    = "172.16.0.0/28"
  default_max_pods_per_node = 10
  remove_default_node_pool  = true

  // pal added config
  network_policy          = true
  configure_ip_masq       = true
  enable_private_endpoint = false
  master_ipv4_cidr_block  = "10.10.60.0/28"
  //  master_ipv4_cidr_block = "173.62.207.192/28"
  // end of pals additions

  node_pools = [
    {
      name              = "pool-01"
      min_count         = 1
      max_count         = 10
      local_ssd_count   = 0
      disk_size_gb      = 20
      disk_type         = "pd-standard"
      image_type        = "COS"
      auto_repair       = true
      auto_upgrade      = true
      service_account   = var.compute_engine_service_account
      preemptible       = false
      max_pods_per_node = 8 // Maximum pods per node must be at least 8 and at most 110
    }
  ]

  master_authorized_networks = [
    {
      cidr_block   = data.google_compute_subnetwork.primary_subnet.ip_cidr_range
      display_name = "VPC"
    },
    {
      cidr_block   = data.google_compute_subnetwork.secondary_subnet.ip_cidr_range
      display_name = "VPC"
    },
    {
      cidr_block   = data.google_compute_subnetwork.tertiary_subnet.ip_cidr_range
      display_name = "VPC"
    },
    {
      cidr_block   = "10.100.10.0/24"
      display_name = "VPC"
    },
    {
      cidr_block   = "10.100.20.0/24"
      display_name = "VPC"
    },
    {
      cidr_block   = "10.100.30.0/24"
      display_name = "VPC"
    }
    //    ,
    //    {
    //      cidr_block   = data.google_compute_subnetwork.primary_subnet.secondary_ip_range
    //      display_name = "VPC"
    //    },
    //    {
    //      cidr_block   = data.google_compute_subnetwork.secondary_subnet.secondary_ip_range
    //      display_name = "VPC"
    //    }
  ]
}

