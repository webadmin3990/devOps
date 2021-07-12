#---------------------------------
# my terraform
#
# Build WebServer during Bootstrap

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  ami = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.tpl", {f_name = "Andrii", l_name = "Shmelov", names = ["Vyasa", "Kolia", "Petya", "John", "Donald"]})

  tags = {
    Name = "WebServer Bild"
    Owner = "Andrii Shmelov"
  }

}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "WebServer Bild"
    Owner = "Andrii Shmelov"
  }
}