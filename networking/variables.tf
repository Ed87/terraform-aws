# --- networking/variables.tf ---

variable "vpc_cidr" {
    type = string
}

variable "public_cidrs" {
  type = list
}

variable "public_sn_count" {
    type = number
}

variable "max_subnets" {
    type =number
}

variable "private_cidrs" {
    type = list
}
variable "private_sn_count" {
    type = number
}

variable "destination_cidr_block" {
    type = string
}

#required for aws_vpc_endpoint
variable "aws_region" {
    type = string
}

variable "name" {}

variable "common_tags" {}

variable "naming_prefix" {}