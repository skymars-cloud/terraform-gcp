// this is ncode from scratch. google cloud module can be used instead
// https://github.com/terraform-google-modules/terraform-google-event-function
locals {
  zip_file_path = "./.function_deployment "
}

data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = var.source_code_folder
  output_path = "${local.zip_file_path}/${var.zip_file_name}"
}


resource "google_storage_bucket" "bkt_function" {
  name = var.bucket_name
}

resource "google_storage_bucket_object" "pager_duty_func" {
  name   = var.zip_file_name
  bucket = google_storage_bucket.bkt_function.name
  source = "${local.zip_file_path}/${var.zip_file_name}"
}

resource "google_cloudfunctions_function" "function" {
  project               = var.project_id
  region                = var.region
  name                  = var.function_name
  description           = var.description
  runtime               = "python39" // "nodejs14"
  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bkt_function.name
  source_archive_object = google_storage_bucket_object.pager_duty_func.name
  trigger_http          = true
  entry_point           = "helloGET"
  timeout               = 300 // 60 to 540 seconds.
  ingress_settings      = "ALLOW_ALL"
  labels = {
    my-label = "my-label-value"
  }

  environment_variables = {
    MY_ENV_VAR = "my-env-var-value"
  }
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
