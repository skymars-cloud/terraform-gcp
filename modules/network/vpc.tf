module "vpc" {
  source                                 = "terraform-google-modules/network/google//modules/vpc"
  version                                = "~> 3.2.2"
  project_id                             = var.project_id
  network_name                           = var.vpc_name
  shared_vpc_host                        = false
  routing_mode                           = "REGIONAL"
  delete_default_internet_gateway_routes = true
}