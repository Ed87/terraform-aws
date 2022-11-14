# --identity/main.tf--

resource "aws_ecr_repository" "efs_ecr" {
  name                 = var.name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_lifecycle_policy" "efs_ecr_policy" {
  repository = aws_ecr_repository.efs_ecr.name

  policy = jsonencode({
    rules = [{
      rulePriority = var.rulePriority
      description  = var.description
      action       = {
        type = var.type
      }
      selection     = {
        tagStatus   =   var.tagStatus
        countType   = var.countType
        countNumber = var.countNumber
      }
    }]
  })
}