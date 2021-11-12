
org_name           = "gsecurity.net"
org_id             = "614830067722"
folder_name_palani = "palani"
folder_id_palani   = "561421552790"

project_id_dev = "prj-dev-palani-ram"
project_id_qa  = "prj-qa-palani-ram"

service_account_id    = "srv-acct-admin"
service_account_email = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"
gsuite_user_email_id  = "palani.ram@googlecloud.corp-partner.google.com"

environment    = "dev"
primary_region = "us-central1"
primary_zone   = "us-central1-f"

zones        = ["us-central1-a", "us-central1-b", "us-central1-f"]
zones_string = "us-central1-a,us-central1-b,us-central1-f"

created_by = "Palani Ram"

vpc_name         = "primary-vpc"
primary_subnet   = "primary-dmz-subnet"
secondary_subnet = "secondary-dmz-subnet"
tertiary_subnet  = "tertiary-dmz-subnet"

create_compute_instance      = false
enable_forseti_server_on_gce = false
enable_gke_module            = false
enable_postgresql_module     = false
enable_mysql_module          = false
enable_mssql_module          = false
enable_bq_module             = false
enable_cloud_function        = false
enable_cloud_dns             = false
enable_custom_governance     = false
enable_gcs_bucket            = false

