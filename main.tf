#--root/main.tf---

module "networking" {
  source   = "./networking"
  vpc_cidr = local.vpc_cidr
  max_subnets      = 20
  public_sn_count = 3
  private_sn_count = 3
  destination_cidr_block = "0.0.0.0/0"
  aws_region = local.aws_region
  #even numbers 4 public subnets
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  #odd numbers 4 public subnets
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  # public_cidrs   = "${cidrsubnet(local.vpc_cidr, 8, 2)}"
  # private_cidrs    = "${cidrsubnet(local.vpc_cidr, 8, 1)}"
}


