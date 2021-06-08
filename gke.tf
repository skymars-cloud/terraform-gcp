// https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/blob/master/docs/private_clusters.md

module "gke-private" {
  source                         = "./modules/gke-private"
  compute_engine_service_account = var.service_account_email
  ip_range_pods                  = "primary-dmz-subnet-secip-1"
  ip_range_services              = "primary-dmz-subnet-secip-2"
  network                        = var.vpc_name
  project_id                     = var.project_id_dev
  region                         = var.primary_region
  subnetwork                     = var.primary_subnet
  depends_on                     = [module.vpc]
  environment                    = var.environment
  zones                          = var.zones
  zones_string                   = var.zones_string
}
