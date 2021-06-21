
data "google_compute_subnetwork" "subnet" {
  name   = var.subnet
  region = var.region
}

locals {
  read_replica_ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = false
    private_network = null
    authorized_networks = [
      {
        name  = "public-cidr"
        value = var.pg_ha_external_ip_range
      }
    ]
  }
}

module "postgresql" {
  source               = "git::https://github.com/terraform-google-modules/terraform-google-sql-db.git//modules/postgresql?ref=master"
  name                 = var.pg_ha_name
  random_instance_name = true
  project_id           = var.project_id
  database_version     = var.database_version
  region               = var.region

  // Master configurations
  tier                            = "db-custom-2-13312"
  zone                            = "us-central1-c"
  availability_type               = "REGIONAL"
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"

  deletion_protection = false

  database_flags = [
    {
      name  = "autovacuum",
      value = "off"
    },
    {
      name : "log_checkpoints",
      value : "on"
    },
    {
      name : "log_connections",
      value : "on"
    },
    {
      name : "log_disconnections",
      value : "on"
    },
    {
      name : "log_temp_files",
      value : "0"
    }
  ]

  user_labels = {
    foo = "bar"
  }

  ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = true
    private_network = null
    authorized_networks = [
      {
        name  = "public-cidr"
        value = "0.0.0.0/0"
      }
    ]
  }

  backup_configuration = {
    enabled                        = true
    start_time                     = "20:55"
    location                       = null
    point_in_time_recovery_enabled = false
    transaction_log_retention_days = 2       // The number of days of transaction logs we retain for point in time restore, from 1-7.
    retention_unit                 = "COUNT" // The unit that 'retained_backups' represents
    retained_backups               = 2       // number of backups. if retention_unit is set to COUNT
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