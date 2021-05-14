terraform {
  required_version = "~> 0.15.3"
  backend "gcs" {
    bucket = "bkt-dev-palani-ram-terraform"
    prefix = "terraform/dev/terraform.tfstate"
  }
}
