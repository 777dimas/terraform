provider "aws" {
    region = var.region
}

/* Get latest Microsoft Server 2016 */
data "aws_ami" "latest_mss_2016" {
    owners = ["801119661308"]
    most_recent = true
        filter {
            name   = "name"
            values = ["EC2LaunchV2-Windows_Server-2016-English-Core-Base-*"] 
            }
        }

resource "aws_instance" "microsoft_server_2016" {
  ami                    = data.aws_ami.latest_mss_2016.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  key_name               = "my_key"
  get_password_data      = "true"
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