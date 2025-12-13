variable "tw_token" {
  type = string
}

variable "project_id" {
  type = number
}

variable "ssh_key_id" {
  type = number
}

variable "private_key_path" {
  type = string
  sensitive = true
}

# VPC
variable "vpc_name" {
  type    = string
  default = "netology-vpc"
}

variable "vpc_subnet_v4" {
  type    = string
  default = "192.168.0.0/24"
}

variable "location" {
  type    = string
  default = "ru-3"
}

# NAT
variable "nat_preset_id" {
  type    = number
  default = 4799
}

variable "nat_os_id" {
  type    = number
  default = 99
}

variable "test" {
  default = "test"
}
