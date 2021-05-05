terraform {
  required_version = "~> 0.14.6"
  backend "gcs" {
    bucket = "bkt-dev-palani-ram-terraform"
    prefix = "terraform/dev/terraform.tfstate"
  }
}
