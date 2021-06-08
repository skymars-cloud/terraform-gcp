
// Project API Activation - this module is not recommended. enable service feature will be removed in future. so use the commands in shell script.
// https://github.com/terraform-google-modules/terraform-google-project-factory/tree/master/modules/project_services#project-api-activation
// this does not enable the services even though it says created (enabled) but tf destroy removes it. DO NOT USE THIS MODULE
module "project-services" {
  // https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest/submodules/project_services
  source                      = "git::https://github.com/terraform-google-modules/terraform-google-project-factory.git//modules/project_services?ref=master"
  project_id                  = var.project_id
  enable_apis                 = true
  disable_dependent_services  = false
  disable_services_on_destroy = false
  activate_apis = [
    "serviceusage.googleapis.com", //  Service Usage API - Enables services that service consumers want to use on Google Cloud Platform
    "vpcaccess.googleapis.com",    // Serverless VPC Access API
    "compute.googleapis.com",
    "iam.googleapis.com",
    "container.googleapis.com", // Kubernetes Engine API
    "containeranalysis.googleapis.com",
    "gkehub.googleapis.com",
    "cloudfunctions.googleapis.com",
    "logging.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbuild.googleapis.com", //  Cloud Build API - Continuously build, test, and deploy.
    "cloudkms.googleapis.com"

  ]
}
//all the above resources are removed from the tf state file
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["cloudbuild.googleapis.com"]'
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["cloudfunctions.googleapis.com"]'
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["cloudresourcemanager.googleapis.com"]'
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["compute.googleapis.com"]'
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["container.googleapis.com"]'
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["containeranalysis.googleapis.com"]'
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["gkehub.googleapis.com"]'
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["iam.googleapis.com"]'
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["logging.googleapis.com"]'
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["serviceusage.googleapis.com"]'
//tf state rm 'module.dev_services.module.project-services.google_project_service.project_services["vpcaccess.googleapis.com"]'