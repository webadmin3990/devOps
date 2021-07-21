output "webserver_instance_id" {
  value = aws_instance.my_server.public_dns
}

output "webserver_public_ip_web" {
  value = aws_eip.my_static_ip.public_ip
}

output "jenkins_instance_id" {
  value = aws_instance.my_jenkins.public_dns
}

output "webserver_public_ip_jenkins" {
  value = aws_eip.my_static_ip_jenkins.public_ip
}

//output "password" {
//  description = "The password is:"
//  sensitive = true
//  value = aws_db_instance.my_db.password
//}

//output "webserver_sg_id" {
//  value = aws_security_group.my_server.id
//}
//
//output "webserver_sg_arn" {
//  value = aws_security_group.my_server.arn
//  description = "This is SecurityGroup ARN"
//}