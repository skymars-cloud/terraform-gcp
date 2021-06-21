
// enable audit logging at project level
resource "google_project_iam_audit_config" "all_services" {
  project = var.project_id
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }
  audit_log_config {
    log_type = "DATA_WRITE"
  }
  audit_log_config {
    log_type = "DATA_READ"
  }
}

resource "google_compute_project_metadata_item" "oslogin" { //  CIS Benchmark v1.2 - 4.4 - gcp_compute_enable_oslogin_project_v1.yaml
  key     = "enable-oslogin"
  value   = "TRUE"
  project = var.project_id
} //  CIS Benchmark v1.2 - 4.4 - gcp_compute_enable_oslogin_project_v1.yaml



//resource "google_project_iam_binding" "project" {
//  project = var.project_id
//  //role    = "roles/iam.ServiceAccountUser"
//  role    = "roles/iam.ServiceAccountTokenCreator"
//  members =  ["srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"]
//}

// CIS Benchmark : 1.6
resource "google_project_iam_member" "project" {
  project = var.project_id
  //role    = "roles/iam.ServiceAccountUser"
  role    = "roles/iam.ServiceAccountTokenCreator"
  member =  "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
}

//
//resource "google_project_iam_member" "project" {
//  project = data.google_project.project.project_id
//  role    = "roles/owner"
//  member  = "user:palani.ram@googlecloud.corp-partner.google.com"
//
//  condition {
//    title       = "expires_after_2022_12_31"
//    description = "Expiring at midnight of 2022-12-31"
//    expression  = "request.time < timestamp(\"2023-01-01T00:00:00Z\")"
//  }
//}

