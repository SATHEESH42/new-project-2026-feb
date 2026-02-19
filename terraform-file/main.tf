# ---------------- SECURITY GROUP ----------------
resource "aws_security_group" "web_sg" {
  name        = "My-Security-Group"
  description = "Allow SSH HTTP HTTPS"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ---------------- EC2 INSTANCE ----------------
resource "aws_instance" "example" {
  ami           = "ami-019715e0d74f695be" # Ubuntu 24.04 (Mumbai)
  instance_type = "t3.micro"

  key_name = "given" # ⭐ YOUR AWS KEY NAME HERE

  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Hello from Terraform EC2</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "my-project-ec2"
  }
}

# ---------------- OUTPUTS ----------------
output "public_ip" {
  value = aws_instance.example.public_ip
}

output "ssh_command" {
  value = "ssh -i given.pem ubuntu@${aws_instance.example.public_ip}"
}

output "website" {
  value = "http://${aws_instance.example.public_ip}"
}