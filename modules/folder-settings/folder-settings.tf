
// enable audit logging at folder level
resource "google_folder_iam_audit_config" "all_services" {
  folder  = var.folder_id
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


