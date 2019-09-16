terraform {
  required_version = ">= 0.12, < 0.13"
  backend "s3" {
    bucket         = "unq-9613826-terraform-state-files"
    key            = "live_envs/stage/as/terraform.tfstate"
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

module "auto_scaling" {
  source                     = "../../../modules/auto_scaling"
  allowed_cidr_blocks        = [var.allowed_cidr_blocks]
  autoscaling_group_max_size = var.a_s_group_max_size
  autoscaling_group_min_size = var.a_s_group_min_size
  public_key                 = var.public_key
  vpc_id                     = data.terraform_remote_state.vpc.outputs.custom_vpc_id
  alb_security_group_id      = [data.terraform_remote_state.alb.outputs.alb-security-group_id]
  alb-target-group_arn       = data.terraform_remote_state.alb.outputs.alb-target-group_arn
  as-subnets_ids             = data.terraform_remote_state.subnets.outputs.subnets_id
}