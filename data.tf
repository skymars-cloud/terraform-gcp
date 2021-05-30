data "google_folder" "palani" {
  folder              = "folders/${var.folder_id_palani}"
  lookup_organization = true
}