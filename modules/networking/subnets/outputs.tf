# Output all subnets IDs.

output "subnets_id" {
  value = aws_subnet.main.*.id
}