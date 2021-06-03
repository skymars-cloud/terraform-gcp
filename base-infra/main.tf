// enable google api services - this should be done first
module "dev_services" {
  source     = "./modules/services"
  project_id = var.project_id_dev
}
