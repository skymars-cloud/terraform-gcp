//data "google_organization" "org" {
//  domain = "gsecurity.net"
//}

// update audit config for organization
//resource "google_organization_iam_audit_config" "org" {
//  org_id  = data.google_organization.org.id
//  service = "allServices"
//  audit_log_config {
//    log_type = "ADMIN_READ"
//  }
//  audit_log_config {
//    log_type = "DATA_WRITE"
//  }
//  audit_log_config {
//    log_type = "DATA_READ"
//  }
//}


// create folder
//resource "google_folder" "folder" {
//  display_name = var.folder_name
//  parent       = "organizations/${var.org_id}"
//}
// enable audit logging at folder level
//resource "google_folder_iam_audit_config" "folder" {
//  folder  = google_folder.folder.id
//  service = "allServices"
//  audit_log_config {
//    log_type = "ADMIN_READ"
//  }
//  audit_log_config {
//    log_type = "DATA_WRITE"
//  }
//  audit_log_config {
//    log_type = "DATA_READ"
//
//  }
//}

//data "google_project" "project" {
//  project_id = var.project_id
//}
// create project
//resource "google_project" "project" {
//  name       = var.project_name
//  project_id = var.project_id
//  folder_id  = google_folder.folder.name
//}
//
//// enable audit logging at project level
//resource "google_project_iam_audit_config" "project" {
//  project = data.google_project.project.project_id
//  service = "allServices"
//  audit_log_config {
//    log_type = "ADMIN_READ"
//  }
//  audit_log_config {
//    log_type = "DATA_WRITE"
//  }
//  audit_log_config {
//    log_type = "DATA_READ"
//  }
//}
//
//resource "google_logging_project_bucket_config" "project" {
//  project        = data.google_project.project.name
//  location       = "global"
//  retention_days = 30
//  bucket_id      = "_Default"
//}
//
//resource "google_project_iam_binding" "project" {
//  project = data.google_project.project.project_id
//  role    = "roles/owner"
//
//  members = [
//    "user:palani.ram@googlecloud.corp-partner.google.com"
//  ]
//}
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

