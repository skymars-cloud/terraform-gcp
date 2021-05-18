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
  name       = "gke-test-1"
  region     = var.region
  zones      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network    = var.vpc_name
  subnetwork = data.google_compute_subnetwork.primary_subnet.name
  //  ip_range_pods     = data.google_compute_subnetwork.secondary_subnet.name
  ip_range_pods = "primary-dmz-subnet-secip-1"
  //  ip_range_services = data.google_compute_subnetwork.tertiary_subnet.name
  ip_range_services = "primary-dmz-subnet-secip-2"

  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = false

  node_pools = [
    {
      name            = "default-node-pool"
      machine_type    = "e2-medium"
      node_locations  = "us-central1-b,us-central1-c"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-standard"
      image_type      = "COS"
      auto_repair     = true
      auto_upgrade    = true
      //      service_account    = "project-service-account@${var.project_id}.iam.gserviceaccount.com"
      service_account    = var.service_account_email
      preemptible        = false
      initial_node_count = 80
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
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}
//cluster creation worked. but node pool creation gives this error
//│ Error: error creating NodePool: googleapi: Error 403:
//│       (1) insufficient regional quota to satisfy request: resource "CPUS": request requires '320.0' and is short '251.0'. project has a quota of '72.0' with '69.0' available. View and manage quotas at https://console.cloud.google.com/iam-admin/quotas?usage=USED&project=prj-dev-palani-ram
//│       (2) insufficient regional quota to satisfy request: resource "IN_USE_ADDRESSES": request requires '160.0' and is short '92.0'. project has a quota of '69.0' with '68.0' available. View and manage quotas at https://console.cloud.google.com/iam-admin/quotas?usage=USED&project=prj-dev-palani-ram., forbidden
//│
//│   with module.gke.module.gke.google_container_node_pool.pools["default-node-pool"],
//│   on .terraform/modules/gke.gke/cluster.tf line 194, in resource "google_container_node_pool" "pools":
//│  194: resource "google_container_node_pool" "pools" {
//│
