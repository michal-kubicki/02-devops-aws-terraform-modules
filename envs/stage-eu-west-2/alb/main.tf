terraform {
  required_version = ">= 0.12, < 0.13"
  backend "s3" {
    bucket         = "unq-9613826-terraform-state-files"
    key            = "live_envs/stage/alb/terraform.tfstate"
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

module "alb" {
  source              = "../../../modules/alb"
  allowed_cidr_blocks = var.allowed_cidr_blocks
  vpc_id              = data.terraform_remote_state.vpc.outputs.custom_vpc_id
  alb_subnets         = data.terraform_remote_state.subnets.outputs.subnets_id
}