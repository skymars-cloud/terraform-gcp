terraform {
  //required_version = "~> 1.0.0"
    required_providers {
      helm = {
        version = "~> 2.2.0"
        //version = "~> 1.0.0"
      }
//      null = {
//        version = "~> 2.1, ~> 3.1.0"
//      }
    }
  backend "gcs" {
    bucket = "bkt-dev-palani-ram-terraform"
    prefix = "terraform/dev/terraform.tfstate"
  }
}
