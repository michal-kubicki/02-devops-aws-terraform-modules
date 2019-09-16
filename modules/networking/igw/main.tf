# Create an Internet Gateway.
resource "aws_internet_gateway" "custom_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.igw_name_tag
  }
}

# Create a routing table entry (a route) in the custom VPC main routing table.
resource "aws_route" "internet_route_table" {
  route_table_id         = var.main_route_table_id
  destination_cidr_block = local.all_ips
  gateway_id             = aws_internet_gateway.custom_igw.id
}