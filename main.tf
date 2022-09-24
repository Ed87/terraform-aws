#--root/main.tf---

module "identity" {
  source = "./identity"
  name   = "administrators"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

module "networking" {
  source   = "./networking"
  vpc_cidr = local.vpc_cidr
}