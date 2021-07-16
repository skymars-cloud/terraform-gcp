resource "google_bigquery_dataset_iam_binding" "READER" {
  dataset_id = module.bigquery_parent.bigquery_dataset.dataset_id
  role       = "roles/bigquery.dataViewer"
  //  role = "READER"  // legacy role not allowed

  members = [
    "serviceAccount:srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
    //    "allUsers","allAuthenticatedUsers"                // CIS Benchmark: 7.1 Ensure that BigQuery datasets are not anonymously or publicly accessible
  ]
  depends_on = [module.bigquery_parent]
}

resource "google_bigquery_dataset_iam_binding" "WRITER" {
  dataset_id = module.bigquery_parent.bigquery_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"
  //  role = "WRITER" // legacy role not allowed

  members = [
    "serviceAccount:srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
    //    "allUsers","allAuthenticatedUsers"                // CIS Benchmark: 7.1 Ensure that BigQuery datasets are not anonymously or publicly accessible
  ]
  depends_on = [module.bigquery_parent]
}

resource "google_bigquery_dataset_iam_binding" "OWNER" {
  dataset_id = module.bigquery_parent.bigquery_dataset.dataset_id
  role       = "roles/bigquery.dataOwner"
  //  role = "OWNER" // legacy role not allowed

  members = [
    "serviceAccount:srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
    //    "allUsers","allAuthenticatedUsers"                // CIS Benchmark: 7.1 Ensure that BigQuery datasets are not anonymously or publicly accessible
  ]
  depends_on = [module.bigquery_parent]
}