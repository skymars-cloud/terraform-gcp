
locals {
  read_replica_ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = false
    private_network = null
    authorized_networks = [
      {
        name  = "public-cidr"
        value = var.mysql_ha_external_ip_range
      },
    ]
  }

}

module "mysql" {
  source               = "git::https://github.com/terraform-google-modules/terraform-google-sql-db.git//modules/mysql?ref=master"
  name                 = var.mysql_ha_name
  random_instance_name = true
  project_id           = var.project_id
  database_version     = var.database_version
  region               = var.region

  deletion_protection = false

  // Master configurations
  tier                            = "db-n1-standard-1"
  zone                            = "us-central1-c"
  availability_type               = "REGIONAL"
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"

  database_flags = [{ name = "long_query_time", value = 1 }]

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
        value = var.mysql_ha_external_ip_range
      },
    ]
  }

  backup_configuration = {
    enabled            = true
    binary_log_enabled = true
    start_time         = "20:55"
    location           = null
  }

  // Read replica configurations
  read_replica_name_suffix = "-test"
  read_replicas = [
    {
      name             = "0"
      zone             = "us-central1-a"
      tier             = "db-n1-standard-1"
      ip_configuration = local.read_replica_ip_configuration
      database_flags   = [{ name = "long_query_time", value = 1 }]
      disk_autoresize  = null
      disk_size        = null
      disk_type        = "PD_HDD"
      user_labels      = { bar = "baz" }
    },
    {
      name             = "1"
      zone             = "us-central1-b"
      tier             = "db-n1-standard-1"
      ip_configuration = local.read_replica_ip_configuration
      database_flags   = [{ name = "long_query_time", value = 1 }]
      disk_autoresize  = null
      disk_size        = null
      disk_type        = "PD_HDD"
      user_labels      = { bar = "baz" }
    },
    {
      name             = "2"
      zone             = "us-central1-c"
      tier             = "db-n1-standard-1"
      ip_configuration = local.read_replica_ip_configuration
      database_flags   = [{ name = "long_query_time", value = 1 }]
      disk_autoresize  = null
      disk_size        = null
      disk_type        = "PD_HDD"
      user_labels      = { bar = "baz" }
    },
  ]

  db_name      = var.mysql_ha_name
  db_charset   = "utf8mb4"
  db_collation = "utf8mb4_general_ci"

  additional_databases = [
    {
      name      = "${var.mysql_ha_name}-additional"
      charset   = "utf8mb4"
      collation = "utf8mb4_general_ci"
    },
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
    },
  ]
}