variable "aws_region" {
  type        = string
  description = "AWS region to use for resources."
  default     = "us-east-1"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "taat"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
  default     = "dev"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources."
  default     = "labs"
}

variable "name" {
  type        = string
  description = "Naming prefix of VPC tag."
  default     = "labs"
}