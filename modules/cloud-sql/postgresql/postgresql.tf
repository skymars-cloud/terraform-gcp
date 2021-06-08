//
//provider "google" {
//  version = "~> 3.22"
//}
//
//provider "null" {
//  version = "~> 2.1"
//}
//
//provider "random" {
//  version = "~> 2.2"
//}

data "google_compute_subnetwork" "primary_subnet" {
  name   = var.primary_subnet
  region = var.primary_region
}

locals {
  read_replica_ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = false
    private_network = null
    authorized_networks = [
      {
        //        name  = "${var.project_id}-cidr"
        name  = var.primary_subnet
        value = var.pg_ha_external_ip_range
      }
    ]
  }
}

module "pg" {
  source               = "git::https://github.com/terraform-google-modules/terraform-google-sql-db.git//modules/postgresql?ref=master"
  name                 = var.pg_ha_name
  random_instance_name = true
  project_id           = var.project_id
  database_version     = "POSTGRES_9_6"
  region               = var.primary_region

  // Master configurations
  tier                            = "db-custom-2-13312"
  zone                            = "us-central1-c"
  availability_type               = "REGIONAL"
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"

  deletion_protection = false

  database_flags = [{ name = "autovacuum", value = "off" }]

  user_labels = {
    foo = "bar"
  }

  ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = true
    private_network = null
    authorized_networks = [
      {
        //        name  = "${var.project_id}-cidr"
        name = var.primary_subnet
        //        value = var.pg_ha_external_ip_range
        value = "0.0.0.0/0"
      }
    ]
  }

  backup_configuration = {
    enabled                        = true
    start_time                     = "20:55"
    location                       = null
    point_in_time_recovery_enabled = false
  }

  // Read replica configurations
  read_replica_name_suffix = "-test"
  read_replicas = [
    {
      name             = "0"
      zone             = "us-central1-a"
      tier             = "db-custom-2-13312"
      ip_configuration = local.read_replica_ip_configuration
      database_flags   = [{ name = "autovacuum", value = "off" }]
      disk_autoresize  = null
      disk_size        = null
      disk_type        = "PD_HDD"
      user_labels      = { bar = "baz1" }
    },
    {
      name             = "1"
      zone             = "us-central1-b"
      tier             = "db-custom-2-13312"
      ip_configuration = local.read_replica_ip_configuration
      database_flags   = [{ name = "autovacuum", value = "off" }]
      disk_autoresize  = null
      disk_size        = null
      disk_type        = "PD_HDD"
      user_labels      = { bar = "baz2" }
    },
    {
      name             = "2"
      zone             = "us-central1-c"
      tier             = "db-custom-2-13312"
      ip_configuration = local.read_replica_ip_configuration
      database_flags   = [{ name = "autovacuum", value = "off" }]
      disk_autoresize  = null
      disk_size        = null
      disk_type        = "PD_HDD"
      user_labels      = { bar = "baz3" }
    },
  ]

  db_name      = var.pg_ha_name
  db_charset   = "UTF8"
  db_collation = "en_US.UTF8"

  additional_databases = [
    {
      name      = "${var.pg_ha_name}-additional"
      charset   = "UTF8"
      collation = "en_US.UTF8"
    }
  ]

  user_name     = "tftest"
  user_password = "foobar"

  additional_users = [
    {
      name     = "tftest2"
      password = "abcdefg"
      host     = "localhost"
    },
    {
      name     = "tftest3"
      password = "abcdefg"
      host     = "localhost"
    }
  ]
}