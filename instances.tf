resource "aws_instance" "web_1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_1.id
  security_groups = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<html><body><h1>Welcome to webserver1 !</h1><p>Your custom message goes here.</p></body></html>" > /var/www/html/index.html
              EOF

  tags = { Name = "WebServer1" }
}

resource "aws_instance" "web_2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_2.id
  security_groups = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<html><body><h1>Welcome to webserver2!</h1><p>Your custom message goes here.</p></body></html>" > /var/www/html/index.html
              EOF

  tags = { Name = "WebServer2" }
}

