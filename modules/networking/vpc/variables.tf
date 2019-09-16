variable "vpc_cidr_block" {
  description = "The range of IPv4 addresses for the VPC in the form of a Classless Inter-Domain Routing (CIDR) block"
  type        = string
}

variable "vpc_name_tag" {
  description = "The name of your new VPC. Will be used for tagging purposes."
  type        = string
  default     = "custom-vpc"
}