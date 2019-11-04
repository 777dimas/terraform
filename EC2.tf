provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "Ubuntu_18" {
  ami           = "ami-0cc0a36f626a4fdf5"
  instance_type = "t3.micro"
  vpc_security_group_ids = [
  aws_security_group.linux_web.id]
  user_data = file("script.sh")

  tags = {
    Name    = "Ubuntu server"
    Project = "Test_terraform"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository deb https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable",
      "sudo apt-get update",
      "sudo apt install docker-ce docker-ce-cli containerd.io",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",
      "sudo docker run -d -p 8888:8080 --restart=always jenkins/jenjins:lts"
    ]
  }
}

resource "aws_security_group" "linux_web" {
  name        = "Web Security Group"
  description = "Allow http_ssh inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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