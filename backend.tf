terraform {
  backend "gcs" {
    bucket = "bkt-dev-palani-ram-terraform"
    prefix = "terraform/dev/terraform.tfstate"
  }
}
