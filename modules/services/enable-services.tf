module "project-services" {
  // https://registry.terraform.io/modules/terraform-google-modules/project-factory/google/latest/submodules/project_services
  source     = "terraform-google-modules/project-factory/google//modules/project_services"
  version    = "10.3.2"
  project_id = var.project_id

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