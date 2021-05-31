
data "google_service_account" "service_account" {
  account_id = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
}

//resource "google_service_account_key" "mykey" {
//  service_account_id = data.google_service_account.service_account.name
//  public_key_type    = "TYPE_X509_PEM_FILE"
//}


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