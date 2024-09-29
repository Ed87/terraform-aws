# --identity/main.tf--

resource "aws_ecr_repository" "orion_ecr" {
  name                 = "${var.name}-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
    tags = merge(var.common_tags, {
    name = "${var.naming_prefix}-ecr"
  })
}

resource "aws_ecr_lifecycle_policy" "orion_ecr_policy" {
  repository = aws_ecr_repository.orion_ecr.name

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