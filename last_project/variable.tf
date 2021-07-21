variable "region" {
  description = "Please Enter AWS Region to AWS server"
  type = string
  default = "ca-central-1"
}

variable "instance_type" {
  description = "Enter Instance Type"
  type = string
  default = "t2.micro"
}

variable "allow_ports" {
  description = "List of Ports to open for server"
  type = list
  default = ["80", "443", "22", "8080", "5000"]
}

variable "enable_detailed_monitoring" {
  type = bool
  default = "false"
}

variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type = map
  default = {
    Owner = "Andrii Shmelov"
    Project = "test"
    CostCenter = "12345"
    Environment = "development"
  }

}