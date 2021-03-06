module "bigquery_parent" {
  source                      = "git::https://github.com/terraform-google-modules/terraform-google-bigquery.git?ref=master"
  dataset_id                  = "foo"
  dataset_name                = "foo"
  description                 = "some description"
  delete_contents_on_destroy  = var.delete_contents_on_destroy
  default_table_expiration_ms = var.default_table_expiration_ms
  project_id                  = var.project_id
  location                    = "US"

  access = [
    {
      role          = "roles/bigquery.dataOwner"
      user_by_email = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
    },
    {
      role          = "roles/bigquery.dataEditor"
      user_by_email = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
    },
    {
      role          = "roles/bigquery.dataViewer"
      user_by_email = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
    }
  ]
  //  access {
  //    role          = "OWNER"
  //    user_by_email = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
  //  }
  //
  //  access {
  //    role          = "WRITER"
  //    user_by_email = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
  //  }
  //
  //  access {
  //    role          = "READER"
  //    user_by_email = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
  //  }

  tables = [
    {
      table_id = "foo",
      schema   = file("${path.module}/sample_bq_schema_json.txt"),
      time_partitioning = {
        type                     = "DAY",
        field                    = null,
        require_partition_filter = false,
        expiration_ms            = null,
      },
      range_partitioning = null,
      expiration_time    = null,
      clustering         = ["fullVisitorId", "visitId"],
      labels = {
        env      = "dev"
        billable = "true"
        owner    = "joedoe"
      },
    },
    {
      table_id          = "bar",
      schema            = file("${path.module}/sample_bq_schema_json.txt"),
      time_partitioning = null,
      range_partitioning = {
        field = "visitNumber",
        range = {
          start    = "1"
          end      = "100",
          interval = "10",
        },
      },
      expiration_time = 2524604400000, # 2050/01/01
      clustering      = [],
      labels = {
        env      = "devops"
        billable = "true"
        owner    = "joedoe"
      },
    }


  ]
  external_tables = [
    {
      scopes                = ["cloud-platform", "https://www.googleapis.com/auth/drive"]
      table_id              = "csv_example"
      autodetect            = true
      compression           = null
      ignore_unknown_values = true
      max_bad_records       = 0
      source_format         = "CSV"
      schema                = null
      expiration_time       = 2524604400000 # 2050/01/01
      labels = {
        env      = "devops"
        billable = "true"
        owner    = "joedoe"
      }
      # DO NOT CHANGE - this is a publicly available file provided by Google
      # see here for reference: https://github.com/GoogleCloudPlatform/cloud-foundation-toolkit/pull/872
      source_uris = ["gs://ci-bq-external-data/bigquery-external-table-test.csv"]
      csv_options = {
        quote                 = "\""
        allow_jagged_rows     = false
        allow_quoted_newlines = true
        encoding              = "UTF-8"
        field_delimiter       = ","
        skip_leading_rows     = 1
      }
      hive_partitioning_options = null
      google_sheets_options     = null
    },
    {
      table_id              = "hive_example"
      autodetect            = true
      compression           = null
      ignore_unknown_values = true
      max_bad_records       = 0
      source_format         = "CSV"
      schema                = null
      expiration_time       = 2524604400000 # 2050/01/01
      labels = {
        env      = "devops"
        billable = "true"
        owner    = "joedoe"
      }
      # DO NOT CHANGE - these are publicly available files provided by Google
      # see here for reference: https://github.com/GoogleCloudPlatform/cloud-foundation-toolkit/pull/872
      source_uris = [
        "gs://ci-bq-external-data/hive_partition_example/year=2012/foo.csv",
        "gs://ci-bq-external-data/hive_partition_example/year=2013/bar.csv"
      ]

      csv_options = null
      hive_partitioning_options = {
        mode = "AUTO"
        # DO NOT CHANGE - see above source_uris
        source_uri_prefix = "gs://ci-bq-external-data/hive_partition_example/"
      }
      google_sheets_options = null
    }

    //    ,
    //    {
    //      scopes = [
    //        "cloud-platform",
    //        "https://www.googleapis.com/auth/drive",
    //        "https://www.googleapis.com/auth/bigquery",
    //        "https://www.googleapis.com/auth/spreadsheets.readonly",
    //        "https://www.googleapis.com/auth/spreadsheets",
    //        "https://www.googleapis.com/auth/drive.readonly"
    //      ]
    //      table_id              = "google_sheets_example"
    //      autodetect            = true
    //      compression           = null
    //      ignore_unknown_values = true
    //      max_bad_records       = 0
    //      source_format         = "GOOGLE_SHEETS"
    //      schema                = null
    //      expiration_time       = 2524604400000 # 2050/01/01
    //      labels = {
    //        env      = "devops"
    //        billable = "true"
    //        owner    = "joedoe"
    //      }
    //      # DO NOT CHANGE - this is a publicly available Google Sheet provided by Google
    //      # see here for reference: https://github.com/GoogleCloudPlatform/cloud-foundation-toolkit/pull/872
    //      source_uris = ["https://docs.google.com/spreadsheets/d/15v4N2UG6bv1RmX__wru4Ei_mYMdVcM1MwRRLxFKc55s"] // original
    //      //      source_uris               = ["https://docs.google.com/spreadsheets/d/1mnh_x_wT2UEAKlk29SL7-rF6REIZkgGMRLd5vtMUkuM"] // pals copy
    //      csv_options               = null
    //      hive_partitioning_options = null
    //      google_sheets_options = {
    //        range             = null
    //        skip_leading_rows = 1
    //      }
    //    }

  ]
  dataset_labels = var.dataset_labels
  encryption_key = var.kms_key
}

module "add_udfs" {
  source     = "git::https://github.com/terraform-google-modules/terraform-google-bigquery.git//modules/udf?ref=master"
  dataset_id = module.bigquery_parent.bigquery_dataset.dataset_id
  project_id = module.bigquery_parent.bigquery_dataset.project
}

