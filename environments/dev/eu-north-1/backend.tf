#--environments/dev/eu-north-1/backend.tf---

 terraform {
    backend "s3" {
      bucket  = "tfstate-bucket-3plct"
      key     = "dev/eu-north-1/remote.tfstate"
      region  = "eu-north-1"
      encrypt = true
    }
  }

