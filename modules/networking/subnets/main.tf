# Create a "public" subnet in every (available) Availability Zone.
resource "aws_subnet" "main" {
  count      = length(data.aws_availability_zones.available.names)
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id     = var.vpc_id

  # Instances launched into the subnet will be assigned a public IP address.
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "public-${element(data.aws_availability_zones.available.names, count.index)}"
  }
}