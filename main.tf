
module "compute_instance" {
  source             = "./modules/gce"
  machine_type       = "e2-micro"
  name               = "pals-jumphost"
  environment        = var.environment
  primary_zone       = var.primary_zone
  service_account_id = var.service_account_id
  organization       = var.organization
}
