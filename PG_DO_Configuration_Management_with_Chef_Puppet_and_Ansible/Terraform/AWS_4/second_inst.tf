provider "aws" {
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  token      = var.AWS_TOKEN
  region     = var.AWS_REGION
}

#terraform {
#  backend "s3" {
#    bucket = "my-terraform-bucket-1928"
#    key    = "mytraining/terraform.tfstate"
#    region = "us-east-1"
#  }
#}

resource "aws_security_group" "webserver_sg" {

  name = "Ports 22"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_instance" "bahman" {
  ami                     = var.AMIS[var.AWS_REGION]
  instance_type           = "t2.micro"
  key_name                = "pem_key"
  vpc_security_group_ids = ["${aws_security_group.webserver_sg.id}"]
  count                   = 3
  tags = {
    Name = "Ubuntu-installation"
  }
}

resource "aws_instance" "bahman1" {
  ami                     = "ami-04902260ca3d33422"
  instance_type           = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.webserver_sg.id}"]
  key_name                = "pem_key"
  count                   = 2
  tags = {
    Name = "alinux-installation"
  }
}
