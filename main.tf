#--root/main.tf---

module "networking" {
  source                 = "./networking"
  vpc_cidr               = local.vpc_cidr
  max_subnets            = 20
  name                   = local.name
  public_sn_count        = 3
  private_sn_count       = 3
  destination_cidr_block = "0.0.0.0/0"
  aws_region             = local.aws_region
  #even numbers 4 public subnets
  public_cidrs = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  #odd numbers 4 public subnets
  private_cidrs = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  common_tags   = local.common_tags
  naming_prefix = local.naming_prefix
}

module "ecr" {
  source        = "./ecr"
  name          = local.name
  tagStatus     = "any"
  countType     = "imageCountMoreThan"
  countNumber   = 3
  description   = "keep last 3 images"
  rulePriority  = 1
  type          = "expire"
  common_tags   = local.common_tags
  naming_prefix = local.naming_prefix
}

module "s3" {
  source        = "./storage"
  common_tags   = local.common_tags
  naming_prefix = local.naming_prefix
  iam_user      = module.iam.s3_aws_iam_user_id
}

module "iam" {
  source        = "./iam"
  common_tags   = local.common_tags
  naming_prefix = local.naming_prefix
}
