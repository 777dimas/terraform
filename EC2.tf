provider "aws" {
  access_key = "AWS_ACCESS_KEY_ID"
  secret_key = "AWS_SECRET_ACCESS_KEY"
  region = "eu-central-1"
}

resource "aws_instance" "linux" {
  ami = "ami-0cc0a36f626a4fdf5"
  instance_type = "t3.micro"
}

