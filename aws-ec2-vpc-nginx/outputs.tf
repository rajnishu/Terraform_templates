output "aws_instance_public_ip" {
  description = "The Public ip of the instance"
  value = aws_instance.nginx-server.public_ip
}

output "instance_url" {
  description = "the url to access the Nginx server"
  value = "http://${aws_instance.nginx-server.public_ip}"
}