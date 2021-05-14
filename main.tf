
module "compute_instance" {
  source                  = "./modules/gce"
  machine_type            = "e2-micro"
  name                    = "pals-jumphost"
  environment             = var.environment
  primary_zone            = var.primary_zone
  service_account_id      = var.service_account_id
  create_compute_instance = var.create_compute_instance
}

module "forseti-on-compute-instance" {
  source                   = "terraform-google-modules/forseti/google"
  version                  = "~> 5.2.0"
  gsuite_admin_email       = "cloud-foundation-forseti-15728@prj-dev-palani-ram.iam.gserviceaccount.com"
  domain                   = "prj-dev-palani-ram.iam.gserviceaccount.com"
  project_id               = var.project_id_dev
  org_id                   = var.org_id
  config_validator_enabled = "true"
}

// create palaniram/prj-prod-palani-ram
module "project" {
  source       = "./modules/project"
  folder_name  = "palaniram"
  org_id       = var.org_id
  project_id   = var.project_id_prod
  project_name = var.project_id_prod
}