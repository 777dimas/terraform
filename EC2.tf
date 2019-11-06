provider "aws" {
  region = "eu-central-1"
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
}

resource "aws_security_group" "linux_web" {
  name        = "Security Group"
  description = "Allow inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8888
    to_port     = 8888
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