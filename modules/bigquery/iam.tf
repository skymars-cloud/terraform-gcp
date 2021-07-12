resource "google_bigquery_dataset_iam_binding" "reader" {
  dataset_id = module.bigquery.bigquery_dataset.dataset_id
  role       = "roles/bigquery.dataViewer"

  members = [
    "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
//    "allUsers","allAuthenticatedUsers"                // CIS Benchmark: 7.1 Ensure that BigQuery datasets are not anonymously or publicly accessible
  ]
  depends_on = [module.bigquery]
}