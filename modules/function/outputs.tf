

// URL which triggers function execution. Returned only if trigger_http is used
output "https_trigger_url" {
  value = google_cloudfunctions_function.function.https_trigger_url
}
