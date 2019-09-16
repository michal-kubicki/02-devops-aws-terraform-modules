locals {
  all_ips = "0.0.0.0/0"
}
variable "vpc_id" {
  description = "The ID of the custom VPC"
  type        = string
}

variable "igw_name_tag" {
  description = "Name for the new IGW"
  type        = string
}

variable "main_route_table_id" {
  description = "The id of the specific Route Table to retrieve"
  type        = string
}