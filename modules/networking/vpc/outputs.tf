# Output the VPC and the main route table IDs.

output "custom_vpc_id" {
  value = aws_vpc.custom_vpc.id
}

output "main_route_table_id" {
  value = aws_vpc.custom_vpc.main_route_table_id
}