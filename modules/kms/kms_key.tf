
// Keys are contained within key rings, and key rings exist within a project.
// we can manage access to keys or key rings, but not to individual key versions.
module "kms" {
  source     = "git::https://github.com/terraform-google-modules/terraform-google-kms.git?ref=master"
  project_id = var.project_id
  keyring    = var.keyring
  location   = "global"
  keys       = var.keys
  # keys can be destroyed by Terraform
  prevent_destroy = false
}
