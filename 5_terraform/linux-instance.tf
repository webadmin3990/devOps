provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_ubuntu" {
//  count = 3
  ami = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"

  tags = {
    name = "My Ubuntu Server"
    Owner = "Andrii Shmelov"
    Project = "Terraform Lesson"
  }
}

resource "aws_instance" "my_Amazon" {
  ami = "ami-00f22f6155d6d92c5"
  instance_type = "t2.micro"

  tags = {
    name = "My Amazon Server"
    Owner = "Andrii Shmelov"
    Project = "Terraform Lesson"
  }
}
