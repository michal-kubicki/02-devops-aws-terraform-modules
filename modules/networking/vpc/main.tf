# Create a custom VPC.
resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr_block

  # Create a Name tag
  tags = {
    Name = var.vpc_name_tag
  }
}