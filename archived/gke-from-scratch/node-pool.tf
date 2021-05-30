data "google_service_account" "admin" {
  account_id = var.service_account_id
}

resource "google_container_node_pool" "np" {
  name    = "dev-gke-node-pool"
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

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    tags         = ["ingress-all", "egress-all"]
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.google_service_account.admin.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  depends_on = [google_container_cluster.primary, random_shuffle.us-central-zones]
}

resource "random_shuffle" "us-central-zones" {
  input = [
    "us-central1-a",
    "us-central1-b",
    "us-central1-c",
    "us-central1-f",
  ]
  result_count = 3
}
