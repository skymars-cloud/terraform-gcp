module "vpc" {
  source           = "./modules/vpc"
  folder_name      = "palani"
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

module "iam" {
  source = "./modules/iam"
}

module "gke" {
  source         = "./modules/gke"
  region         = var.primary_region
  primary_subnet = var.primary_subnet
  project_id     = var.project_id_dev
  project_name   = var.project_id_dev
  vpc_name       = var.vpc_name
  //  //  depends_on     = [module.vpc] // Providers cannot be configured within modules using count, for_each or depends_on.
  service_account_id = var.service_account_id
  //  compute_engine_service_account = var.service_account_id
  //  ip_range_pods                  = ""
  //  ip_range_services              = ""
  //  network                        = ""
  //  project_id                     = ""
  //  region                         = ""
  //  subnetwork                     = ""
  secondary_subnet      = var.secondary_subnet
  tertiary_subnet       = var.tertiary_subnet
  service_account_email = var.service_account_email
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




//
//module "forseti-server-on-gce" {
//  // here is the latest version of terraform modules from forseti. we can take the version number from here. 5.2.2 released on Jul 28, 2020
//  // https://registry.terraform.io/modules/terraform-google-modules/forseti/google/latest
//  source                   = "terraform-google-modules/forseti/google"
//  version                  = "~> 5.2.2"
//  gsuite_admin_email       = "cloud-foundation-forseti-15728@prj-dev-palani-ram.iam.gserviceaccount.com"
//  domain                   = "prj-dev-palani-ram.iam.gserviceaccount.com"
//  project_id               = var.project_id_dev
//  org_id                   = var.org_id
//  config_validator_enabled = "true"
//}

// create palaniram/prj-prod-palani-ram
//module "project" {
//  source       = "./modules/project"
//  folder_name  = "palaniram"
//  org_id       = var.org_id
//  project_id   = var.project_id_prod
//  project_name = var.project_id_prod
//
//}