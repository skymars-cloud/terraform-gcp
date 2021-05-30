module "folder" {
  source    = "./modules/folder-settings"
  folder_id = data.google_folder.palani.id
}

module "project_dev" {
  source       = "./modules/project-settings"
  org_id       = var.org_id
  project_id   = var.project_id_dev
  project_name = var.project_id_dev
}

// enable gcp services on dev project
module "dev_services" {
  source     = "./modules/services"
  project_id = var.project_id_dev
}

module "iam" {
  source = "./modules/iam"
}
