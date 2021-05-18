
module "subnets" {
  // https://registry.terraform.io/modules/terraform-google-modules/network/google/latest
  source       = "terraform-google-modules/network/google//modules/subnets"
  version      = "3.2.2"
  project_id   = var.project_id
  network_name = module.network.network_name

  subnets = [
    {
      subnet_name   = var.primary_subnet
      subnet_ip     = "10.10.10.0/24"
      subnet_region = var.primary_region
    },
    {
      subnet_name           = var.secondary_subnet
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = var.primary_region
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
      description           = "This subnet has a description"
    },
    {
      subnet_name               = var.tertiary_subnet
      subnet_ip                 = "10.10.30.0/24"
      subnet_region             = var.primary_region
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "primary-dmz-subnet-secip"
        ip_cidr_range = "192.168.10.0/24"
      }
    ]

    subnet-02 = [
      {
        range_name    = "secondary-dmz-subnet-secip"
        ip_cidr_range = "192.168.10.0/24"
      }
    ]
  }
  depends_on = [module.network]
}