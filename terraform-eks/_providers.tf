terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # explicit dependency versions prevent breakage from new releases 
      version = ">= 4.57"
    }
  }
  backend "s3" {
    # values passed from CLI
  }
}

# default aws provider that uses aws credentials of your current env
provider "aws" {
  default_tags {
    tags = var.tags
  }
}

data "aws_caller_identity" "current" {}
