locals {
  bucketname  = "proyecto-devops-bucket-${var.environment}"
  clustername = "eks-cluster-${var.environment}"
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = local.bucketname
  acl    = "private"

  tags = {
    Environment = var.environment
    bucketname  = local.bucketname
  }
}

# test comment
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
 