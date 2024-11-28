#--environments/dev/eu-central-1/main.tf---

module "s3" {
  source        = "../../../modules/storage"
  common_tags   = local.common_tags
  naming_prefix = local.naming_prefix
  iam_user      = module.iam.s3_aws_iam_user_id
}

module "iam" {
  source        = "../../../modules/iam"
  common_tags   = local.common_tags
  naming_prefix = local.naming_prefix
}
