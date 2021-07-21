provider "aws" {
  region = "ca-central-1"
}

variable "vps_cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
  cidr_block = var.vps_cidr
  tags = {
    Name = "My VPS"
  }
}

