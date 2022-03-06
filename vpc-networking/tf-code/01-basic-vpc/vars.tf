/* Variables definitions */
variable "vpc_cidr_block" {
  type        = string
  description = "IP Prefix assigned to the VPC"
}

variable "default_name_tag" {
  type        = string
  description = "Default tag to name resources"
  default     = "SAA"
}