//module "kubernetes-engine" {
//  source  = "terraform-google-modules/kubernetes-engine/google"
//  version = "14.3.0"
//  # insert the 9 required variables here
//}

# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  // https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform
  // https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest
  source                     = "terraform-google-modules/kubernetes-engine/google"
  version                    = "14.3.0"
  project_id                 = var.project_id
  name                       = "dev-gke-cluster"
  region                     = var.region
  zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network                    = var.vpc_name
  subnetwork                 = var.primary_subnet
  ip_range_pods              = "us-central1-dev-gke-cluster-01-pods"
  ip_range_services          = "us-central1-dev-gke-cluster-01-services"
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = false

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
      node_locations     = "us-central1-b,us-central1-c"
      min_count          = 1
      max_count          = 100
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "project-service-account@${var.project_id}.iam.gserviceaccount.com"
      preemptible        = false
      initial_node_count = 8
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
      node-pool-metadata-custom-value = "dev-gke-node-pool"
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