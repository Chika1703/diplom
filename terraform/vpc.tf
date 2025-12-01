# Создание VPC
resource "twc_vpc" "main" {
  name       = var.vpc_name
  subnet_v4  = var.vpc_subnet_v4
  location   = var.location
}