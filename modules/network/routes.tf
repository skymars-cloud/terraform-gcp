module "routes" {
  // https://github.com/terraform-google-modules/terraform-google-network/tree/master/modules/routes
  source  = "terraform-google-modules/network/google//modules/routes"
  version = "~> 3.2.2"

  project_id   = var.project_id
  network_name = var.vpc_name

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
  //  depends_on = [module.vpc]
}