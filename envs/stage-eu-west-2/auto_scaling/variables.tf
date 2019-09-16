variable "allowed_cidr_blocks" {
  description = "The IP range alowed to connect from."
  type        = string
  default     = "0.0.0.0/0"
}
variable "public_key" {
  description = "Name of the existing SSH key pair to use with EC2 instances."
  type        = string
  default     = "Key" # Don't rofget to set the key pair name.
}
variable "a_s_group_min_size" {
  description = "The minimum size of the auto scaling group."
  type        = number
  default     = 3
}
variable "a_s_group_max_size" {
  description = "The maximum size of the auto scaling group."
  type        = number
  default     = 4
}