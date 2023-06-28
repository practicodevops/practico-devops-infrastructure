terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # backend "s3" {
  #   bucket = "proyecto-devops-terraform-state"
  #   key    = "state/terraform.tfstate"
  #   region = "us-east-1"  

  #   dynamodb_table = "terraform-dev-state-table"
  # }
}

provider "aws" {
  region = "us-east-1"
}