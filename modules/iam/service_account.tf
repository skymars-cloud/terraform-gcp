
data "google_service_account" "service_account" {
  account_id = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
}
// every resource needs an iam module, so put the iam.tf inside every module with right roles and users who has access to that role

// look into the modules in this repo for all IAM role associations
// https://github.com/terraform-google-modules/terraform-google-iam.git

// add these roles to service account srv-acct-admin using terraform
// Actions Admin
//Browser
//Cloud Asset Viewer
//Catalog Admin
//Catalog Org Admin
//Cloud SQL Admin
//Compute Admin
//Compute Instance Admin (beta)
//Compute Network Admin
//Compute Organization Resource Admin
//Compute Security Admin
//Security Admin
//Security Reviewer
//Service Account Admin
//Logging Admin
//Logs Configuration Writer
//Monitoring Admin
//Owner
//Organization Administrator
//Security Center Admin
//Security Center Findings Editor
//Security Center Notification Configurations Editor
//Service Usage Admin
//Stackdriver Accounts Editor
//Storage Admin
//Threat Detection Settings Editor
//Serverless VPC Access Admin

resource "null_resource" "before" {
}

resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 10"
  }
  triggers = {
    "before" = "${null_resource.before.id}"
  }
}

resource "null_resource" "after" {
  depends_on = ["null_resource.delay"]
}

resource "google_service_account" "service_account" {
  account_id   = var.service_account_id_readonly
  display_name = "Service Account"
}



resource "google_service_account_iam_binding" "admin" {
  //  service_account_id = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
  service_account_id = google_service_account.service_account.account_id
  role               = "roles/iam.serviceAccountAdmin"

  members = [
    "user:${var.gsuite_user_email_id}",
    "group:palani.ram@googlecloud.corp-partner.google.com"
  ]
}

resource "google_service_account_iam_binding" "user" {
  //  service_account_id = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
  service_account_id = "102616608851799474468"
  role               = "roles/iam.serviceAccountUser"

  members = [
    "user:palani.ram@googlecloud.corp-partner.google.com",
    "user:${var.gsuite_user_email_id}"
  ]
}
