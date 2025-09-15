resource "random_id" "suffix" {
  byte_length = 3
}

locals {
  resolved_bucket_name = coalesce(var.bucket_name, lower(replace("${var.project_name}-${var.environment}-${random_id.suffix.hex}", "_", "-")))
}

resource "aws_s3_bucket" "this" {
  bucket        = local.resolved_bucket_name
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

locals {
  sample_project_subfolders = [
    "checkpoints",
    "model",
    "test",
    "training",
    "validation",
  ]
}

resource "aws_s3_object" "sample_project_root" {
  bucket  = aws_s3_bucket.this.id
  key     = "${var.initial_project_name}/"
  content = ""
}

resource "aws_s3_object" "sample_project_subfolders" {
  for_each = toset(local.sample_project_subfolders)
  bucket   = aws_s3_bucket.this.id
  key      = "${var.initial_project_name}/${each.key}/"
  content  = ""
}