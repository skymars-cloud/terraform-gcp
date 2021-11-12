
// this has invalid provide version numbers configured in base module, pal could not override them.
// here are the invalid versions, the version should be 3 digits like 2.1.0 . thats how it is available in tf registry
//null = {
//      source  = "hashicorp/null"
//      version = "~> 2.1"
//    }
//    random = {
//      source  = "hashicorp/random"
//      version = "~> 2.2"
//    }

//module "forseti-server-on-gce" {
//  count = var.enable_forseti_server_on_gce ? 1 : 0
//  // https://registry.terraform.io/modules/terraform-google-modules/forseti/google/latest
//  //  source                   = "terraform-google-modules/forseti/google"
//  //  version                  = "~> 5.2.2"
//  source                      = "git::https://github.com/forseti-security/terraform-google-forseti.git?ref=master"
//  gsuite_admin_email       = "cloud-foundation-forseti-15728@prj-dev-palani-ram.iam.gserviceaccount.com"
//  domain                   = "prj-dev-palani-ram.iam.gserviceaccount.com"
//  project_id               = var.project_id_dev
//  org_id                   = var.org_id
//  config_validator_enabled = "true"
////  providers = {
////    null = null.pals_null
////    random = random.pals_random
////    kubernetes = kubernetes.pals_kubernetes
////  }
//}