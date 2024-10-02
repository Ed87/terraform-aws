terraform {
  backend "s3" {
    bucket = "tfstate-bucket-kpzyy"
    key    = "remote.tfstate"
    region = "eu-north-1"
    encrypt = true
  }
}