locals {
  bucketname  = "proyecto-devops-bucket-${var.environment}"
  clustername = "eks-cluster-${var.environment}"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = local.bucketname
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
  policy = templatefile("policies/s3-policy.json", { bucket = local.bucketname })

  depends_on = [ aws_s3_bucket_public_access_block.s3_public_access ]
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = local.clustername
  role_arn = var.role_arn

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.security_group]
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks-cluster-node-group"
  node_role_arn   = var.role_arn

  subnet_ids = var.subnet_ids

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 1
  }

  instance_types = [var.ec2_instance_type]
  capacity_type  = "ON_DEMAND"

  tags = {
    Environment = var.environment
  }
}

 