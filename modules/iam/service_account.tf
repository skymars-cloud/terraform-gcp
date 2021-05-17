//resource "google_service_account" "myaccount" {
//  account_id   = var.account_id
//  display_name = "My Service Account"
//  project      = var.project_id
//}

data "google_service_account" "service_account" {
  account_id = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
}

//resource "google_service_account_key" "mykey" {
//  service_account_id = data.google_service_account.service_account.name
//  public_key_type    = "TYPE_X509_PEM_FILE"
//}