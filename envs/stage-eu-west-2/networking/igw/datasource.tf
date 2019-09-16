data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "unq-9613826-terraform-state-files"
    key    = "live_envs/stage/networking/vpc/terraform.tfstate"
    region = "eu-west-2"
  }
}