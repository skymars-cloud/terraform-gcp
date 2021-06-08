
org_name           = "gsecurity.net"
org_id             = "614830067722"
folder_name_palani = "palani"
folder_id_palani   = "561421552790"

project_id_dev = "prj-dev-palani-ram"
project_id_qa  = "prj-qa-palani-ram"

service_account_id    = "srv-acct-admin"
service_account_email = "srv-acct-admin@prj-dev-palani-ram.iam.gserviceaccount.com"

environment    = "dev"
primary_region = "us-central1"
primary_zone   = "us-central1-f"

zones        = ["us-central1-a", "us-central1-b", "us-central1-f"]
zones_string = "us-central1-a,us-central1-b,us-central1-f"

created_by = "Palani_Ram"

vpc_name         = "primary-vpc"
primary_subnet   = "primary-dmz-subnet"
secondary_subnet = "secondary-dmz-subnet"
tertiary_subnet  = "tertiary-dmz-subnet"

create_compute_instance  = true
enable_gke_module        = true
enable_postgresql_module = true
enable_mysql_module      = true
enable_mssql_module      = true

