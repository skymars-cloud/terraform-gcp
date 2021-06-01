

module "vpc" {
  source           = "./modules/vpc"
  folder_name      = var.folder_name_palani
  org_id           = var.org_id
  primary_region   = var.primary_region
  primary_subnet   = var.primary_subnet
  primary_zone     = var.primary_zone
  project_id       = var.project_id_dev
  project_name     = var.project_id_dev
  secondary_subnet = var.secondary_subnet
  tertiary_subnet  = var.tertiary_subnet
  vpc_name         = var.vpc_name
}

module "compute_instance" {
  source                  = "./modules/gce"
  project_id              = var.project_id_dev
  machine_type            = "e2-micro"
  name                    = "pals-jumphost"
  environment             = var.environment
  primary_zone            = var.primary_zone
  service_account_id      = var.service_account_id
  create_compute_instance = var.create_compute_instance
  region                  = var.primary_region
  subnet                  = var.primary_subnet
  vpc_name                = var.vpc_name
  depends_on              = [module.vpc]
}

