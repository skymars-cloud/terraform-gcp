
variable "org_name" {
  type = string
}

variable "org_id" {
  type = string
}

variable "folder_name_palani" {
  type = string
}
variable "folder_id_palani" {
  type = string
}

variable "project_id_dev" {
  type = string
}
variable "project_id_qa" {
  type = string
}

variable "environment" {
  type = string
}

variable "primary_region" {
  type = string
}

variable "primary_zone" {
  type = string
}
variable "zones" {
  type = list(string)
}
variable "zones_string" {
  type = string
}

variable "created_by" {
  type = string
}
variable "service_account_id" {
  type = string
}
variable "service_account_email" {
  type = string
}

variable "create_compute_instance" {
  type = bool
}
variable "enable_gke_module" {
  type = bool
}

variable "vpc_name" {
  type = string
}

variable "primary_subnet" {
  type = string
}
variable "secondary_subnet" {
  type = string
}
variable "tertiary_subnet" {
  type = string
}