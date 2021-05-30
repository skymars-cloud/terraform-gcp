# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

data "google_compute_subnetwork" "primary_subnet" {
  name   = var.primary_subnet
  region = var.region
}
data "google_compute_subnetwork" "secondary_subnet" {
  name   = var.secondary_subnet
  region = var.region
}
data "google_compute_subnetwork" "tertiary_subnet" {
  name   = var.tertiary_subnet
  region = var.region
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source     = "terraform-google-modules/kubernetes-engine/google"
  project_id = var.project_id
  name       = "gke-test-cluster"
  region     = var.region
  zones      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network    = var.vpc_name
  subnetwork = data.google_compute_subnetwork.primary_subnet.name
  //  ip_range_pods     = data.google_compute_subnetwork.secondary_subnet.name
  ip_range_pods = "primary-dmz-subnet-secip-1"
  //  ip_range_services = data.google_compute_subnetwork.tertiary_subnet.name
  ip_range_services         = "primary-dmz-subnet-secip-2"
  default_max_pods_per_node = 8 // Maximum pods per node must be at least 8 and at most 110

  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = false

  node_pools = [
    {
      name            = "default-node-pool"
      machine_type    = "e2-medium"
      node_locations  = "us-central1-b,us-central1-c"
      min_count       = 1
      max_count       = 10
      local_ssd_count = 0
      disk_size_gb    = 20
      disk_type       = "pd-standard"
      image_type      = "COS"
      auto_repair     = true
      auto_upgrade    = true
      //      service_account    = "project-service-account@${var.project_id}.iam.gserviceaccount.com"
      service_account    = var.service_account_email
      preemptible        = false
      initial_node_count = 2
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = ["ingress-all", "egress-all"]

    default-node-pool = [
      "default-node-pool",
    ]
  }

}
