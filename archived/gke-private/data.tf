
data "google_compute_subnetwork" "primary_subnet" {
  name    = var.primary_subnet
  project = var.project_id
  region  = var.region
}

data "google_compute_subnetwork" "secondary_subnet" {
  name    = var.secondary_subnet
  project = var.project_id
  region  = var.region
}

data "google_compute_subnetwork" "tertiary_subnet" {
  name    = var.tertiary_subnet
  project = var.project_id
  region  = var.region
}

