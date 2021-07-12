provider "aws" {
  region = "ca-central-1"
}

data "aws_ami" "latest_ubuntu" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazon" {
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64"]
  }
}

resource "aws_instance" "my_webserver" {
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = "t2.micro"
   tags = {
    Name = "WebServer Bild"
    Owner = "Andrii Shmelov"
  }
}


output "laters_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}

output "laters_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}

output "laters_amazon_ami_id" {
  value = data.aws_ami.latest_amazon.id
}

output "laters_amazon_ami_name" {
  value = data.aws_ami.latest_amazon.name
}