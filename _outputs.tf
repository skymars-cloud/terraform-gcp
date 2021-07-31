
output "random_string" {
  value       = random_string.random.result
  description = "random_string generated"
}
output "random_id_b64_std" {
  value       = random_id.server.b64_std
  description = "random_id generated"
}
output "random_id_b64_url" {
  value       = random_id.server.b64_url
  description = "random_id generated"
}
output "random_shuffle" {
  value       = random_shuffle.az.result
  description = "random_shuffle generated"
}

