variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "service_accounts" {
  description = "List of service accounts & IAM permissions"
  type = list(object({
    service_account_name        = string
    service_account_permissions = map(list(string))
    }
  ))
}

