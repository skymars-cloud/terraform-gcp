output "service_account_emails" {
  description = "The service account emails."
  value       = module.service_accounts.emails
}

output "service_account_emails_list" {
  description = "The service account emails as a list."
  value       = module.service_accounts.emails_list
}

output "service_account_iam_emails" {
  description = "The service account IAM-format emails as a map."
  value       = module.service_accounts.iam_emails
}

output "service_account_keys" {
  description = "The service account keys."
  value       = module.service_accounts.keys
}