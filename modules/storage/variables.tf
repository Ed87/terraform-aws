# --- storage/variables.tf ---

#required for bucket acces
variable "iam_user" {
  type = string
}

variable "common_tags" {}

variable "naming_prefix" {}