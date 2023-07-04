locals {
  bucketname = "proyecto-devops-bucket-${var.environment}"
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = local.bucketname
  acl    = "private"

  tags = {
    Environment = var.environment
    bucketname  = local.bucketname
  }
}