#--- storage/main.tf ---

# create state backend bucket
resource "aws_s3_bucket" "state_backend_bucket" {
  bucket = "tfstate-bucket-${random_string.random.result}"

  tags = merge(var.common_tags, {
    Name = "${var.naming_prefix}-tfstate-bucket"
  })
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