variable "aws_region" {
  type        = string
  description = "AWS region to use for resources."
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "orion"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
  default     = "dev"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all 'name' tags."
  default     = "labs"
}

variable "name" {
  type        = string
  description = "Naming prefix for all resources with name property."
}

variable "vpc_cidr" {
  type        = string
  description = "VPC subnet to provision resources in."
}