locals {
  bucketname = "proyecto-devops-bucket-${var.environment}"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = local.bucketname
  force_destroy = true

  tags = {
    Environment = var.environment
    bucketname  = local.bucketname
  }
}

resource "aws_s3_bucket_website_configuration" "s3_website_configuration" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_public_access" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : [
          "arn:aws:s3:::${local.bucketname}",
          "arn:aws:s3:::${local.bucketname}/*"
        ]
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.s3_public_access]
}