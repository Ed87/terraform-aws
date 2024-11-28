#--environments/dev/eu-central-1/backend.tf---

terraform {
  backend "s3" {
    bucket  = "tfstate-bucket-x6w4t"
    key     = "dev/eu-central-1/remote.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}

