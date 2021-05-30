
//
//module "forseti-server-on-gce" {
//  // here is the latest version of terraform modules from forseti. we can take the version number from here. 5.2.2 released on Jul 28, 2020
//  // https://registry.terraform.io/modules/terraform-google-modules/forseti/google/latest
//  source                   = "terraform-google-modules/forseti/google"
//  version                  = "~> 5.2.2"
//  gsuite_admin_email       = "cloud-foundation-forseti-15728@prj-dev-palani-ram.iam.gserviceaccount.com"
//  domain                   = "prj-dev-palani-ram.iam.gserviceaccount.com"
//  project_id               = var.project_id_dev
//  org_id                   = var.org_id
//  config_validator_enabled = "true"
//}