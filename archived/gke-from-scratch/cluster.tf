data "google_container_engine_versions" "central1b" {
  provider       = google-beta
  location       = "us-central1-b"
  version_prefix = "1.20."
}
# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

//provider "kubernetes" {
//  load_config_file       = false
//  host                   = "https://${module.gke.endpoint}"
//  token                  = data.google_client_config.default.access_token
//  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
//}
//



//resource "google_service_account" "gke" {
//  account_id   = "project-service-account@${var.project_id}.iam.gserviceaccount.com"
//  display_name = "GKE Service Account"
//}

resource "google_container_cluster" "primary" {
  name         = "dev-gke-cluster"
  network      = var.vpc_name
  subnetwork   = var.primary_subnet
  node_version = data.google_container_engine_versions.central1b.latest_node_version

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

