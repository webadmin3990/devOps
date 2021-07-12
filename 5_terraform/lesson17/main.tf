#-------------------------------------------------------------------
# Provision Highly Available Web inany Region Default PC
# Create:
#     - Security Group for Web Server
#     - Launch Configuration with Auto AMI Lookup
#     - Auto Scaling Group using 2 Availability Zones
#     - Classic Load Balancer in 2 Availability Zones
#
# Made by Andrii Shmelov 11--07-2021
#-------------------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

data "aws_availability_zones" "available" {}
data "aws_ami" "latest_ubuntu_linux" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

#---------------------------------------------------
resource "aws_security_group" "web" {
  name = "WebServer Security Group"
  description = "My First SecurityGroup"

  dynamic "ingress" {
    for_each = ["80", "443", "22"]
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

  tags = {
    Name = "My SecurityGroup"
    Owner = "Andii Shmelov"
  }
}

resource "aws_launch_configuration" "web" {
//  name = "WebServer-Highly-Available-LC"
  name_prefix = "WebServer-Highly-Available-LC-"
  image_id = data.aws_ami.latest_ubuntu_linux.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web.id]
  user_data = file("user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name = "ASG-${aws_launch_configuration.web.name}"
  launch_configuration = aws_launch_configuration.web.name
  max_size = 2
  min_size = 2
  min_elb_capacity = 2
  health_check_type = "ELB"
  vpc_zone_identifier = [aws_default_subnet.default_az1.id,aws_default_subnet.default_az2.id]
  load_balancers = [aws_elb.web.name]

  dynamic "tag" {
    for_each = {
      Name = "WebServer in ASG"
      Owner = "Shmelov Andrii"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_elb" "web" {
  name = "WebServer-HA-ELB"
  availability_zones = [data.aws_availability_zones.available.names[0],data.aws_availability_zones.available.names[1]]
  security_groups = [aws_security_group.web.id]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    interval = 10
    target = "HTTP:80/"
    timeout = 3
    unhealthy_threshold = 2
  }
  tags = {
    Name = "WebServer-Highly-Available-ELB"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.available.names[1]
}

#-----------------------------------------------------------
output "web_balancer_url" {
  value = aws_elb.web.dns_name
}