provider "aws" {
    region = var.region
}

/* Get latest debian 10*/
data "aws_ami" "latest_debian_10" {
    owners = ["136693071363"]
    most_recent = true
        filter {
            name   = "name"
            values = ["debian-10-amd64-*"] 
            }
        }

resource "aws_instance" "debian" {
  ami           = data.aws_ami.latest_debian_10.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data     = <<EOF
  #!/bin/bash
  apt update
  apt upgrade -y
  apt install mc vim -y
  EOF
  key_name      = "my_key"
  tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Build Server by Terraform" })
}

resource "aws_security_group" "my_security_group" {
    name = "temp"
    description = "Security group for my temp server"  

    dynamic "ingress" {
    for_each = var.allow_ports
    content {
      description = "Allow ssh port"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.cidr_blocks
      }
    }

    egress {
      description = "Allow all out trafic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(var.common_tags, { Name = "${var.common_tags["Environment"]} Build SG by terraform" })
}