resource "random_id" "random_project_id_suffix" {
  byte_length = 2
}

locals {
  base_project_id = var.project_id_dev
  new_project_id  = format("%s-%s", local.base_project_id, random_id.random_project_id_suffix.hex)
  //  new_project_id = format("%s-%s", local.base_project_id, random_string.random.result)
}

// to reproduce https://github.com/GoogleCloudPlatform/terraform-validator/issues/254 -- this issue not related this type of tf terraform
// to reproduce https://github.com/GoogleCloudPlatform/terraform-validator/issues/139 -- cannot reproduce this issue. so the issue was fixed in terraform validator
//resource "google_project" "new_project" {
//  name       = "new-pals-project"
//  project_id = local.new_project_id
//}


resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

resource "random_id" "server" {
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    ami_id = "${var.create_compute_instance}"
  }

  byte_length = 8
}

resource "random_shuffle" "az" {
  input        = ["us-west-1a", "us-west-1c", "us-west-1d", "us-west-1e"]
  result_count = 2
}