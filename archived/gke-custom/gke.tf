
# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

//provider "kubernetes" {
//  load_config_file       = false
//  host                   = "https://${module.gke.endpoint}"
//  token                  = data.google_client_config.default.access_token
//  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
//}
//


data "google_service_account" "admin" {
  //  account_id = "project-service-account@${var.project_id}.iam.gserviceaccount.com"
  account_id = var.service_account_id
}
//resource "google_service_account" "gke" {
//  account_id   = "project-service-account@${var.project_id}.iam.gserviceaccount.com"
//  display_name = "GKE Service Account"
//}

//service_account_id
resource "google_container_cluster" "primary" {
  name = "dev-gke-cluster"
  //  location   = "us-central1"
  network    = var.vpc_name
  subnetwork = var.primary_subnet

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  //  node_locations           = [for zone in random_shuffle.us-central-zones.result : zone]
  //  node_locations = [random_shuffle.us-central-zones.result]
  //  depends_on = [random_shuffle.us-central-zones]
  timeouts {
    create = "60m"
    update = "30m"
    delete = "40m"
  }
}

resource "google_container_node_pool" "np" {
  name = "dev-gke-node-pool"
  //  location = "us-central1-a"
  cluster = google_container_cluster.primary.name
  node_config {
    machine_type = "e2-medium"
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    //    service_account = google_service_account.gke.email
    service_account = data.google_service_account.admin.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  timeouts {
    create = "60m"
    update = "30m"
    delete = "40m"
  }
  initial_node_count = 2
  //  node_count         = 3 // nodes per intance
  //  region         = var.region
  node_locations = [for zone in random_shuffle.us-central-zones.result : zone]
  depends_on     = [google_container_cluster.primary, random_shuffle.us-central-zones]
}

resource "random_shuffle" "us-central-zones" {
  //  id = "us-central-zones"
  input = [
    "us-central1-a",
    "us-central1-b",
    "us-central1-c",
    "us-central1-f",
  ]
  result_count = 3
}
