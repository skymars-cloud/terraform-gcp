// https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/blob/master/docs/private_clusters.md

//module "gke" {
//  source                         = "./modules/gke"
//  cluster_name_suffix            = "-pal"
//  compute_engine_service_account = var.service_account_email
//  ip_range_pods                  = "primary-dmz-subnet-secip-1"
//  ip_range_services              = "primary-dmz-subnet-secip-2"
//  network                        = var.vpc_name
//  project_id                     = var.project_id_dev
//  region                         = var.primary_region
//  subnetwork                     = var.primary_subnet
//  enable_gke_module              = var.enable_gke_module
//  depends_on                     = [module.vpc]
//  primary_subnet                 = var.primary_subnet
//  secondary_subnet               = var.secondary_subnet
//  tertiary_subnet                = var.tertiary_subnet
//}
