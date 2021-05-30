
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
    },
    {
      subnet_name   = "serverless-vpc-sbt-10-10-40-0" // 12 usable ips (16 - 4 )
      subnet_ip     = "10.10.40.0/28"
      subnet_region = var.primary_region
    },
    {
      subnet_name   = "serverless-vpc-sbt-10-10-50-0" // 12 usable ips (16 - 4 )
      subnet_ip     = "10.10.50.0/28"
      subnet_region = var.primary_region
    }
  ]

  secondary_ranges = {
    primary-dmz-subnet = [
      {
        range_name    = "primary-dmz-subnet-secip-1"
        ip_cidr_range = "10.100.10.0/24"
      },
      {
        range_name    = "primary-dmz-subnet-secip-2"
        ip_cidr_range = "10.100.20.0/24"
      }
    ]

    secondary-dmz-subnet = [
      {
        range_name    = "secondary-dmz-subnet-secip"
        ip_cidr_range = "10.100.30.0/24"
      }
    ]
  }
  depends_on = [module.network]
}