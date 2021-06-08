

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 1.1.0"
  name    = "pals-cloud-router"
  project = var.project_id
  region  = var.primary_region
  network = var.vpc_name
}

module "cloud_nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "~> 2.0.0"
  project_id = var.project_id
  region     = var.primary_region
  router     = "pals-cloud-router"
  depends_on = [module.cloud_router]
}