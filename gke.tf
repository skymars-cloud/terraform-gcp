
//module "gke" {
//  source                         = "./modules/gke"
//  cluster_name_suffix            = "-pal"
//  compute_engine_service_account = var.service_account_id
//  ip_range_pods                  = "primary-dmz-subnet-secip-1"
//  ip_range_services              = "primary-dmz-subnet-secip-2"
//  network                        = var.vpc_name
//  project_id                     = var.project_id_dev
//  region                         = var.primary_region
//  subnetwork                     = var.primary_subnet
//  enable_gke_module              = var.enable_gke_module
//  depends_on                     = [module.vpc]
//}
