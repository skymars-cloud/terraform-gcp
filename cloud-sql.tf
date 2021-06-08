module "postgresql-ha" {
  count                   = var.enable_postgresql_module ? 1 : 0
  source                  = "./modules/cloud-sql/postgresql-ha"
  pg_ha_external_ip_range = "0.0.0.0/0"
  project_id              = var.project_id_dev
  region                  = var.primary_region
  subnet                  = var.primary_subnet
  database_version        = "POSTGRES_13"
}

module "mysql-ha" {
  count                      = var.enable_mysql_module ? 1 : 0
  source                     = "./modules/cloud-sql/mysql-ha"
  project_id                 = var.project_id_dev
  region                     = var.primary_region
  mysql_ha_external_ip_range = "0.0.0.0/0"
  database_version           = "MYSQL_8_0"
}

module "mssql-public" {
  count            = var.enable_mssql_module ? 1 : 0
  source           = "./modules/cloud-sql/mssql-public"
  project_id       = var.project_id_dev
  region           = var.primary_region
  database_version = "SQLSERVER_2017_STANDARD"
}