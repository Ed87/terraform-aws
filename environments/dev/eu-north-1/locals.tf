#--- environments/dev/eu-north-1/locals.tf ---

locals {
  name          = var.name
  naming_prefix = "${var.company}-${var.environment}"
  common_tags = {
    createdBy = "Terraform"
    owner     = "DevOps"
  }
}

