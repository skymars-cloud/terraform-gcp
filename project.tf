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

module "project" {
  source                = "./modules/project"
  project_id            = var.project_id_dev
  gsuite_user_email_id  = var.gsuite_user_email_id
  service_account_email = var.service_account_email
}

//module "iam" {
//  source               = "./modules/iam"
//  gsuite_user_email_id = var.gsuite_user_email_id
//}
