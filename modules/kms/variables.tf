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


variable "group_email" {
  type        = string
  description = "Email for group to receive roles (ex. group@example.com)"
}

variable "sa_email" {
  type        = string
  description = "Email for Service Account to receive roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com)"
}

variable "user_email" {
  type        = string
  description = "Email for group to receive roles (Ex. user@example.com)"
}

variable "kms_crypto_keys" {
  type        = list(string)
  description = "list of kms_cripto_key to add the IAM policies/bindings"
}
variable "kms_key_rings" {
  type        = list(string)
  description = "list of kms_key_rings to add the IAM policies/bindings"
}

variable "key_rotation_period" {
  type = string
}

