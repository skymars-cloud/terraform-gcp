module "bucket" {
  source     = "git::https://github.com/terraform-google-modules/terraform-google-cloud-storage.git//modules/simple_bucket?ref=master"
  name       = var.bucket_name
  project_id = var.project_id
  location   = var.region

  //uniform_bucket_level_access = true

  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age        = 30
      with_state = "ANY"
    }
  }]

  iam_members = [
    {
      role   = "roles/storage.objectAdmin"
      member = "serviceAccount:${var.service_account_email}"

    }
  ]
}


