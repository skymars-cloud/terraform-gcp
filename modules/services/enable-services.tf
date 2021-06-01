module "project-services" {
  // https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest/submodules/project_services
  source                      = "git::https://github.com/terraform-google-modules/terraform-google-project-factory.git//modules/project_services?ref=master"
  project_id                  = var.project_id
  enable_apis                 = true
  disable_dependent_services  = true
  disable_services_on_destroy = false
  activate_apis = [
    "vpcaccess.googleapis.com", // Serverless VPC Access API
    "compute.googleapis.com",
    "iam.googleapis.com",
    "container.googleapis.com", // Kubernetes Engine API
    "containeranalysis.googleapis.com",
    "gkehub.googleapis.com",
    "cloudfunctions.googleapis.com",
    "logging.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com"
  ]
}
