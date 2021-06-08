
module "kms" {
  source     = "git::https://github.com/terraform-google-modules/terraform-google-kms.git?ref=master"
  project_id = var.project_id
  keyring    = var.keyring
  location   = "global"
  keys       = var.keys
  # keys can be destroyed by Terraform
  prevent_destroy = false
}
