
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
  //vpc_name         = "default"                 // CIS Benchmark: 3.1 Ensure that the default network does not exist in a project
  vpc_name = var.vpc_name
}

module "compute_instance" {
  //  for_each = var.create_compute_instance ? 1 : 0
  count                 = var.create_compute_instance ? 1 : 0
  source                = "./modules/gce"
  project_id            = var.project_id_dev
  machine_type          = "e2-micro"
  name                  = "pals-jumphost"
  environment           = var.environment
  primary_zone          = var.primary_zone
  service_account_id    = var.service_account_id
  region                = var.primary_region
  subnet                = var.primary_subnet
  vpc_name              = var.vpc_name
  service_account_email = var.service_account_email
  depends_on            = [module.vpc, module.kms_key]
}

// url to invoke the function https://us-central1-prj-dev-palani-ram.cloudfunctions.net/hello-world
module "fn_hello" {
  count              = var.enable_cloud_function ? 1 : 0
  source             = "./modules/function"
  project_id         = var.project_id_dev
  bucket_name        = "bkt-pals-functions"
  description        = "pals-functions"
  function_name      = "hello-world"
  region             = var.primary_region
  source_code_folder = "./python"
  zip_file_name      = "hello-world.zip"
}

module "cis_bucket" {
  count                 = var.enable_gcs_bucket ? 1 : 0
  source                = "./modules/gcs"
  bucket_name           = "cis_pals_bkt"
  bucket_prefix         = var.project_id_dev
  project_id            = var.project_id_dev
  service_account_email = var.service_account_email
  region                = var.primary_region
}

// this module creates 2 services accounts sa-first and sa-second and adds all iam roles
module "service-accounts" {
  source     = "./modules/service-accounts"
  project_id = var.project_id_dev
}

module "cloud-dns" {
  count      = var.enable_cloud_dns ? 1 : 0
  source     = "./modules/dns"
  project_id = var.project_id_dev
}

//module "cg" {
//  count             = var.enable_custom_governance ? 1 : 0
//  source            = "./modules/custom-governance"
//  app_user_email_id = var.gsuite_user_email_id
//  org_id            = var.org_id
//  org_name          = var.org_name
//  project_id        = var.project_id_dev
//  project_name      = var.project_id_dev
//  load_config_file  = false
//}

