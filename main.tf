#--root/main.tf---

module "identity" {
  source = "./identity"
  name   = "administrators"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

module "networking" {
  source   = "./networking"
  vpc_cidr = local.vpc_cidr
  max_subnets      = 20
  public_sn_count = 1
  private_sn_count = 1
  container_port = 80
  destination_cidr_block = "0.0.0.0/0"
  #even numbers for public subnets
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  #odd numbers for public subnets
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)] 
  

  # public_cidrs   = "${cidrsubnet(local.vpc_cidr, 8, 2)}"
  # private_cidrs    = "${cidrsubnet(local.vpc_cidr, 8, 1)}"
}

module "ecr" {
  source = "./ecr"
  name   = "efs-aws-ecr"
  tagStatus = "any"
  countType   = "imageCountMoreThan"
  countNumber = 3
  description = "keep last 3 images"
  rulePriority   = 1
  type = "expire"
  # image_tag_mutability = "MUTABLE"
}
