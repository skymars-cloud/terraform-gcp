//resource "google_vpc_access_connector" "connector" {
//  //  provider = google-beta
//  name = "svl-vpc-con-10-100-1-0"
//  subnet {
//    name = "serverless-vpc-sbt-10-100-1-0"
//  }
//  machine_type  = "e2-micro"
//  ip_cidr_range = "10.100.1.0/28"
//  network       = var.vpc_name
//  region        = var.primary_region
//}

resource "google_vpc_access_connector" "svl-vpc-con-10-100-1-32" {
  project        = var.project_id
  name           = "svl-vpc-con-10-100-1-32"
  ip_cidr_range  = "10.100.1.32/28"
  network        = var.vpc_name
  region         = var.primary_region
  min_throughput = 200
  max_throughput = 1000
}

module "vpc_connector_firewall_rules" {
  // https://github.com/terraform-google-modules/terraform-google-network/tree/release-v3.2.2/modules/firewall-rules
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = var.vpc_name

  rules = [
    {
      name        = "vpc-connector-ingress"
      description = "vpc-connector-ingress"
      direction   = "INGRESS"
      priority    = null
      // https://cloud.google.com/vpc/docs/configure-serverless-vpc-access - NAT / Health check IP ranges used by serverless services
      ranges                  = ["107.178.230.64/26", "35.199.224.0/19", "130.211.0.0/22", "35.191.0.0/16", "108.170.220.0/23"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["vpc-connector"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["0-65535"]
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    },
    {
      name        = "vpc-connector-egress"
      description = "vpc-connector-egress"
      direction   = "EGRESS"
      priority    = null
      // https://cloud.google.com/vpc/docs/configure-serverless-vpc-access - NAT / Health check IP ranges used by serverless services
      ranges                  = ["107.178.230.64/26", "35.199.224.0/19", "130.211.0.0/22", "35.191.0.0/16", "108.170.220.0/23"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = ["vpc-connector"]
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["0-65535"]
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    }
  ]

  depends_on = [module.network]
}