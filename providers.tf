terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
  access_key = "AKIAX3HPOH57DIVT3OMY"
  secret_key = "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"
}