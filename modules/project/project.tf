resource "google_project" "project" {
  name       = var.project_name
  project_id = var.project_id
  folder_id  = google_folder.folder.name
}

resource "google_folder" "folder" {
  display_name = var.folder_name
  parent       = "organizations/${var.org_id}"
}

resource "google_project_iam_binding" "project" {
  project = google_project.project.project_id
  role    = "roles/owner"

  members = [
    "user:palani.ram@googlecloud.corp-partner.google.com"
  ]
}

resource "google_project_iam_member" "project" {
  project = var.project_id
  role    = "roles/owner"
  member  = "user:palani.ram@googlecloud.corp-partner.google.com"

  condition {
    title       = "expires_after_2022_12_31"
    description = "Expiring at midnight of 2022-12-31"
    expression  = "request.time < timestamp(\"2023-01-01T00:00:00Z\")"
  }
}
