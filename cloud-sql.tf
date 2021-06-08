module "postgresql" {
  count                   = var.enable_gke_module ? 1 : 0
  source                  = "./modules/cloud-sql/postgresql"
  pg_ha_external_ip_range = "0.0.0.0/0"
  project_id              = var.project_id_dev
  region                  = var.primary_region
  subnet                  = var.primary_subnet
}