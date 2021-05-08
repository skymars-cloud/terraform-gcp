resource "google_project" "my_project-in-a-folder" {
  name       = var.project_name
  project_id = var.project_id
  folder_id  = google_folder.department.name
}

resource "google_folder" "department" {
  display_name = var.folder_name
  parent       = "organizations/${var.org_id}"
}