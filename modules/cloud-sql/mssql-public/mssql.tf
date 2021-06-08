
module "mssql" {
  source               = "git::https://github.com/terraform-google-modules/terraform-google-sql-db.git//modules/mssql?ref=master"
  name                 = var.name
  database_version     = var.database_version
  random_instance_name = true
  project_id           = var.project_id
  user_name            = "simpleuser"
  user_password        = "foobar"
  deletion_protection  = false
}