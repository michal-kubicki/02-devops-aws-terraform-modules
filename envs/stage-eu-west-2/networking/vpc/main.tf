terraform {
  required_version = ">= 0.12, < 0.13"
  backend "s3" {
    bucket         = "unq-9613826-terraform-state-files"
    key            = "live_envs/stage/networking/vpc/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-2"

  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

module "vpc" {
  source         = "../../../../modules/networking/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  vpc_name_tag   = "stage_vpc"
}
