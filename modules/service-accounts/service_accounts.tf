module "service_accounts" {
  source        = "git::https://github.com/terraform-google-modules/terraform-google-service-accounts.git?ref=master"
  project_id    = var.project_id
  prefix        = ""
  names         = ["sa-first", "sa-second"]
  generate_keys = true
  display_name  = "CIS Benchmark Test Service Accounts"
  description   = "CIS Benchmark Test Service Accounts description"

  project_roles = [
    "${var.project_id}=>roles/viewer",
    "${var.project_id}=>roles/storage.objectViewer",
    "${var.project_id}=>roles/iam.serviceAccountAdmin",
    "${var.project_id}=>roles/iam.serviceAccountUser"
  ]
}