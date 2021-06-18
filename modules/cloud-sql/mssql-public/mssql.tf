module "mssql" {
  source                      = "git::https://github.com/terraform-google-modules/terraform-google-sql-db.git//modules/mssql?ref=master"
  name                        = var.name
  database_version            = var.database_version
  random_instance_name        = true
  project_id                  = var.project_id
  user_name                   = "simpleuser"
  user_password               = "foobar"
  deletion_protection         = false
  authorized_gae_applications = null

  backup_configuration = { // CIS Benchmarks v1.2 - 6.7 gcp_sql_backup_v1.yaml
    enabled                        = true
    start_time                     = "20:00"
    binary_log_enabled             = null
    point_in_time_recovery_enabled = null
    transaction_log_retention_days = 2       // The number of days of transaction logs we retain for point in time restore, from 1-7.
    retention_unit                 = "COUNT" // The unit that 'retained_backups' represents
    retained_backups               = 2       // number of backups. if retention_unit is set to COUNT
  }                                          // CIS Benchmarks v1.2 - 6.7 gcp_sql_backup_v1.yaml

  // violations for CIS Benchmark 6.5 & 6.6
  //  ip_configuration = {
  //    ipv4_enabled        = true                     // CIS Benchmarks v1.2 - 6.6 gcp_sql_public_ip_v1.yaml
  //    private_network     = null
  //    require_ssl         = null
  //    authorized_networks = [{                       // CIS Benchmarks v1.2 - 6.5 gcp_sql_world_readable_v1.yaml
  //      expiration_time = "11:00"
  //      name = "allopen"
  //      value = "0.0.0.0/0"                          // CIS Benchmarks v1.2 - 6.5 gcp_sql_world_readable_v1.yaml
  //    }]                                             // CIS Benchmarks v1.2 - 6.5 gcp_sql_world_readable_v1.yaml
  //  }

}