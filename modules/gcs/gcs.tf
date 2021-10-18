module "bucket" {
  source             = "git::https://github.com/terraform-google-modules/terraform-google-cloud-storage.git//modules/simple_bucket?ref=master"
  name               = var.bucket_name
  project_id         = var.project_id
  location           = var.region
  bucket_policy_only = false //CIS Benchmark v1.2 - 5.2 - gcp_storage_bucket_policy_only.yaml

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
      //violation fix:CIS Benchmark v1.2 - 5.1 - gcp_storage_bucket_world_readable.yaml
      role   = "roles/storage.objectAdmin"
      member = "serviceAccount:${var.service_account_email}"

      //violations either of below conditions
      //role   = "roles/storage.objectAdmin"                   //CIS Benchmark v1.2 - 5.1 - gcp_storage_bucket_world_readable.yaml
      //member = "allUsers"                                    //CIS Benchmark v1.2 - 5.1 - gcp_storage_bucket_world_readable.yaml
      //role   = "roles/storage.objectAdmin"                   //CIS Benchmark v1.2 - 5.1 - gcp_storage_bucket_world_readable.yaml
      //member = "allAuthenticatedUsers"                       //CIS Benchmark v1.2 - 5.1 - gcp_storage_bucket_world_readable.yaml
    }
  ]
}