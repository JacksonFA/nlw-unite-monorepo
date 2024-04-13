terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.22.0"
    }
  }
  backend "s3" {
    bucket = "dgc-infra-terraform"
    key = "terraform-prod.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}