resource "aws_instance" "nginx-server" {
  ami                         = "ami-002f6e91abff6eb96"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.Public-subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]


  user_data = <<-EOF
            #!/bin/bash
            sudo yum install nginx -y
            sudo systemctl start nginx
            EOF

  tags = {
    Name = "nginx-server"
  }
}
