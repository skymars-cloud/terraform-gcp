module "app" {
  source                   = "gcs::https://www.googleapis.com/storage/v1/custom-governance-release/terraform-module/terraform-custom-governance-v1.4.1.zip//terraform-custom-governance/examples/external_ip"
  project_id               = var.project_id
  static_ip_name           = google_compute_global_address.ext-ip-cg-appserver.name
  hostname                 = "CG_DOMAIN_NAME"
  initial_setup_user_email = var.app_user_email_id
  master_authorized_networks = [
    {
      cidr_block   = "0.0.0.0/0",      // we can keep this to private subnet and have a jump host in that subnet to connect to the kubernetes master
      display_name = "Deployment host" // we can give any name here
    }
  ]
  // After initial GKE cluster setup Helm Release may not be able to read cluster server info and will error out with "default cluster has no server defined" error.
  // To get around this, use "gcloud container clusters get-credentials" to initialize kubeconfig to point to your new cluster and set this variable to true.
  load_config_file = false // false for first apply than true


}



