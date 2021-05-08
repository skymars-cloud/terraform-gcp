
module "compute_instance" {
  source                  = "./modules/gce"
  machine_type            = "e2-micro"
  name                    = "pals-jumphost"
  environment             = var.environment
  primary_zone            = var.primary_zone
  service_account_id      = var.service_account_id
  create_compute_instance = var.create_compute_instance
}

module "forseti" {
  source                   = "terraform-google-modules/forseti/google"
  version                  = "~> 5.2.0"
  gsuite_admin_email       = "cloud-foundation-forseti-15728@prj-dev-palani-ram.iam.gserviceaccount.com"
  domain                   = "prj-dev-palani-ram.iam.gserviceaccount.com"
  project_id               = "prj-dev-palani-ram"
  org_id                   = "614830067722"
  config_validator_enabled = "true"
}

module "project" {
  source       = "./modules/project"
  folder_name  = "palaniram"
  org_id       = var.org_id
  project_id   = "prj-prod-palani-ram"
  project_name = "prj-prod-palani-ram"
}