module "routes" {
  // https://github.com/terraform-google-modules/terraform-google-network/tree/master/modules/routes
  source  = "terraform-google-modules/network/google//modules/routes"
  version = "~> 3.2.2"

  project_id   = var.project_id
  network_name = var.vpc_name

  routes = [
    {
      name        = "egress-internet"
      description = "route through IGW to access internet"
      // https://cloud.google.com/vpc-service-controls/docs/set-up-private-connectivity
      destination_range = "0.0.0.0/0" // 199.36.153.4/30 - this range is enough for accessing google apis
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
  depends_on = [module.network]
}