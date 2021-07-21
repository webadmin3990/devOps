// Use region
provider "aws" {
  region = var.region
}

resource "tls_private_key" "kk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "awskeys"
  public_key = tls_private_key.kk.public_key_openssh
  provisioner "local-exec" {
    command = "echo '${tls_private_key.kk.private_key_pem}' > ~/.ssh/myKey.pem"
//    command = "chmod 400 myKey.pem"
  }
}


// Find last ubuntu OS 20.04
data "aws_ami" "latest_ubuntu_linux" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

// Generate static ip to my server (not free)
resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_server.id
  tags = {
    Name = "my_static_ip"
    Owner = "Andrii Shmelov"
  }
}

// Generate static IP for my Jenkins
resource "aws_eip" "my_static_ip_jenkins" {
  instance = aws_instance.my_server.id
  tags = {
    Name = "my_static_ip_jenkins"
    Owner = "Andrii Shmelov"
  }
}

// Create my server with
resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.latest_ubuntu_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.my_server.id]
  monitoring             = var.enable_detailed_monitoring
  user_data = file("webserver.sh")

  tags = {
    Name = "my_server"
    Owner = "Andrii Shmelov"
  }
  depends_on             = [aws_instance.my_jenkins, aws_db_instance.my_db]
 }

// Create jenkins
resource "aws_instance" "my_jenkins" {
  ami                     = data.aws_ami.latest_ubuntu_linux.id
  instance_type           = var.instance_type
  key_name                = aws_key_pair.generated_key.key_name
  vpc_security_group_ids  = [aws_security_group.my_server.id]
  monitoring              = var.enable_detailed_monitoring
  user_data               = file("jenkins.sh")

  tags = {
    Name = "my_jenkins"
    Owner = "Andrii Shmelov"
  }
 }

// Generate Password
//resource "random_password" "password" {
//  length           = 16
//  special          = true
//  override_special = "_%@"
//}

// Create db
//resource "aws_db_instance" "my_db" {
//    identifier           = "prod-rds"
//    allocated_storage    = 20
//    storage_type         = "gp2"
//    engine               = "mysql"
//    engine_version       = "5.7"
//    instance_class       = "db.t2.micro"
//    name                 = "test"
//    username             = "andrea"
//    password             = random_password.password.result
//    parameter_group_name = "default.mysql5.7"
//    skip_final_snapshot  = true
//    apply_immediately    = true
//}

resource "aws_security_group" "my_server" {
  name = "WebServer Security Group"
  description = "My First SecurityGroup"

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port = ingress.value
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
  }

//  tags = merge(var.common_tags, {Name = "${var.common_tags["Environment"]} Server SecurityGroup"})
}
