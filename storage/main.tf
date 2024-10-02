#--- storage/main.tf ---

# create state backend bucket
resource "aws_s3_bucket" "state_backend_bucket" {
  bucket = "tfstate-bucket-${random_string.random.result}"

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-tfstate-bucket"
  })
}

resource "aws_s3_bucket_policy" "grant_iam_user_access" {
  bucket = aws_s3_bucket.state_backend_bucket.id
  policy = data.aws_iam_policy_document.iam_user_tfstate_bucket_access.json
}

data "aws_iam_policy_document" "iam_user_tfstate_bucket_access" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["${var.iam_user}"]
    }

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.state_backend_bucket.arn
    ]
  }
}

# enable S3 bucket versioning
resource "aws_s3_bucket_versioning" "state_backend_bucket_versioning" {
  bucket = aws_s3_bucket.state_backend_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# avoid bucket name conflict
resource "random_string" "random" {
  length           = 5
  special          = false
  upper            = false
  override_special = "/@£$"
}

