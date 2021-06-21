
provider "google" {
  project = var.project_id_dev
  region  = var.primary_region
  zone    = var.primary_zone
  // credentials json file path by default read from GOOGLE_APPLICATION_CREDENTIALS environment variable
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "pals-kubernetes-context"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}