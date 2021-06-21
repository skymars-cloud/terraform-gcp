locals {
  cluster_name = "nc-${var.environment}-cluster-ue1"
}

data "google_project" "project" {
  project_id = var.project_id
}

module "gke-cluster" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                    = "15.0.0"
  project_id                 = var.project_id
  name                       = local.cluster_name
  region                     = var.region
  zones                      = var.zones
  network                    = var.network
  subnetwork                 = var.subnetwork
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  http_load_balancing        = true
  horizontal_pod_autoscaling = true
  network_policy             = false
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "172.16.0.32/28" // this should be added to ingress firewall rule
  release_channel            = "REGULAR"
  remove_default_node_pool   = true
  create_service_account     = false
  default_max_pods_per_node  = 10
  node_pools = [
    {
      name               = "new-pool"
      machine_type       = "n2d-standard-2"
      node_locations     = var.zones_string
      min_count          = 1
      max_count          = 10
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-balanced"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = var.compute_engine_service_account
      preemptible        = false
      initial_node_count = 1
      max_pods_per_node  = 8 // Maximum pods per node must be at least 8 and at most 110
    }
  ]
  master_authorized_networks = [
    {
      cidr_block   = "0.0.0.0/0", // we can keep this to private subnet and have a jump host in that subnet to connect to the kubernetes master
      display_name = "CloudNAT"   // we can give any name here
    }
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/cloud_debugger"
    ]

    new-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/cloud_debugger"
    ]
  }

  node_pools_tags = {
    new-pool = [
      "egress-all", //
      "egress-inet" // IGW tag to have it associated to the node pool
    ]
  }
}