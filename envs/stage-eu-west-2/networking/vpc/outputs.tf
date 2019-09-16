output "custom_vpc_id" {
  value = module.vpc.custom_vpc_id
}

output "route_table_id" {
  value = module.vpc.main_route_table_id
}