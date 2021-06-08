variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "location" {
  description = "Location for the keyring."
  type        = string
  default     = "global"
}

variable "keyring" {
  description = "A key ring organizes keys in a specific Google Cloud location and allows you to manage access control on groups of keys"
  type        = string
}

variable "keys" {
  description = "Key names."
  type        = list(string)
}