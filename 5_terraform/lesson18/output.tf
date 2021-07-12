output "webserver_instance_id" {
  value = aws_instance.my_server.id
}

output "webserver_public_id" {
  value = aws_eip.my_static_ip.public_ip
}

output "webserver_sg_id" {
  value = aws_security_group.my_server.id
}

output "webserver_sg_arn" {
  value = aws_security_group.my_server.arn
  description = "This is SecurityGroup ARN"
}