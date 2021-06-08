locals {
  cluster_name = "nc-${var.environment}-cluster-ue1"
}

data "google_project" "project" {
  project_id = var.project_id
}

module "gke-cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "14.3.0"

  project_id = var.project_id
  name       = local.cluster_name
  //  region                     = "us-east1"
  //  zones                      = ["us-east1-b", "us-east1-c", "us-east1-d"]
  //  network                    = "vpc-app"
  //  subnetwork        = "sn-app-ue1"
  //  ip_range_pods     = "gke-pods-1"
  //  ip_range_services = "gke-services-1"
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
  master_ipv4_cidr_block     = "172.16.0.32/28"
  # cluster_resource_labels    = { "mesh_id" : "proj-${data.google_project.project.number}" }
  release_channel          = "REGULAR"
  remove_default_node_pool = true
  create_service_account   = false
  node_pools = [
    {
      name            = "default-pool"
      machine_type    = "n2-highmem-8"
      node_locations  = "us-east1-b,us-east1-c,us-east1-d"
      min_count       = 1
      max_count       = 10
      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-balanced"
      image_type      = "COS_CONTAINERD"
      auto_repair     = true
      auto_upgrade    = true
      service_account = var.compute_engine_service_account
      preemptible     = false
      # initial_node_count = 80
    },
  ]

  master_authorized_networks = [
    {
      //      cidr_block   = var.cloud_nat_cidr,
      display_name = "CloudNAT"
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}