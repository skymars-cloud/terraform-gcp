// CIS Benchmark 1.8 Ensure that Separation of duties is enforced while assigning service account related roles to users (Not Scored)
// Ensure that there are no common users found in the member section for roles roles/iam.serviceAccountAdmin and roles/iam.serviceAccountUser
resource "google_project_iam_binding" "serviceAccountAdmin" {
  project = var.project_id
  role    = "roles/iam.serviceAccountAdmin"

  members = [
    "user:${var.gsuite_user_email_id}",
    "serviceAccount:${var.service_account_email}"
  ]
}

resource "google_project_iam_binding" "serviceAccountUser" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"

  members = [
    "user:${var.gsuite_user_email_id}"
  ]
}