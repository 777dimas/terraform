provider "aws" {
  region = "eu-central-1"
}

resource "awp_eip" "my_static_ip" {
  instance = aws_instance.Ubuntu_docker_jenkins.id
}

resource "aws_instance" "Ubuntu_docker_jenkins" {
  ami                    = "ami-0cc0a36f626a4fdf5"
  instance_type          = "t3.micro"
  key_name               = "myubuntukey"
  vpc_security_group_ids = [aws_security_group.linux_web.id]
  user_data              = file("docker.sh")

  tags = {
    Name    = "Ubuntu server"
    Project = "Terraform"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "linux_web" {
  name        = "Security Group"
  description = "Allow inbound traffic"

  dynamic "ingress" {
    for_each = ["22", "8888"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }	
  }   

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
