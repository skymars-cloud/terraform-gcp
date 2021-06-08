variable "project_id" {
  type        = string
  description = "The project to run tests against"
}

variable "name" {
  type        = string
  description = "The name for Cloud SQL instance"
  default     = "tf-mssql-public"
}

variable "region" {
  type = string
}
variable "database_version" {
  type = string
}
