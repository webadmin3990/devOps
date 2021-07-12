#---------------------------------
# my terraform
#
# Build WebServer during Bootstrap

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_server_web" {
  ami = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags = {
    Name = "Server-Web"
  }

  depends_on = [aws_instance.my_server_db]
}

resource "aws_instance" "my_server_app" {
  ami = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags = {
    Name = "Server-Application"
  }

  depends_on = [aws_instance.my_server_db]
}

resource "aws_instance" "my_server_db" {
  ami = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags = {
    Name = "Server-Database"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "My First SecurityGroup"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
    content {
      from_port =  ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "My SecurityGroup"
  }
}