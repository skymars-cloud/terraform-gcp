variable "environment" {
  type = string
}

variable "project_id" {
  description = "The project ID to host the cluster in"
}


variable "region" {
  description = "The region to host the cluster in"
}

variable "network" {
  description = "The VPC network to host the cluster in"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
}
variable "ip_range_services" {
  description = "The secondary ip range to use for services"
}
variable "zones" {
  type = list(string)
}
variable "zones_string" {
  type = string
}
