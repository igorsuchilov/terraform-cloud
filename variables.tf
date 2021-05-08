variable "region" {
      default = "eu-central-1"
}

variable "enable_dns_support" {
    default = "true"
}

variable "enable_dns_hostnames" {
    default ="true" 
}

variable "enable_classiclink" {
    default = "false"
}

variable "enable_classiclink_dns_support" {
    default = "false"
}

  variable "preferred_number_of_public_subnets" {
      default = null
}
  variable "preferred_number_of_private_subnets_1" {
      default = null
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  default     = ["10.0.1.0/20", "10.0.3.0/20"]
  type        = list
  description = "List of public subnet CIDR blocks"
}
variable "internet_gateway_name" {
      default = null
}
variable "environment" {
      default = null
}
variable "nat_gateway_name" {
      default = null
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.0.2.0/20", "10.0.4.0/20"]
}
variable "account_no" {
  default = "696742900004"
}
variable "kms_arn" {
  default = "arn:aws:kms:eu-central-1:696742900004:key/"
}