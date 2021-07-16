
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
