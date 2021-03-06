variable "project_id" {
  type        = string
  description = "The project to run tests against"
}

variable "pg_ha_name" {
  type        = string
  description = "The name for Cloud SQL instance"
  default     = "tf-pg-ha"
}

variable "pg_ha_external_ip_range" {
  type        = string
  description = "The ip range to allow connecting from/to Cloud SQL"
}
variable "region" {
  type = string
}
variable "subnet" {
  type = string
}
variable "database_version" {
  type = string
}