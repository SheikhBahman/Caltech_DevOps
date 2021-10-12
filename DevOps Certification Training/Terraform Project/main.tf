#VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "region" {
  default = "us-east-1"
}

# PROVIDERS
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

# DATA
data "aws_ami" "aws_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# RESOURCES
# Default VPC, it won't delete on destroy
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "allow_ssh_http_80" {
  name        = "allow_ssh_http"
  description = "Allow ssh on 22 & http on port 80"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "nginx" {
  ami                    = data.aws_ami.aws_linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_http_80.id]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [ 

      "sudo yum -y update",

      "sudo yum install python37",
      "sudo yum remove java-1.7.0-openjdk.x86_64 -y",
      "yes | sudo yum install java-1.8.0",
      
      "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum update -y",
      "sudo yum install epel-release -y",
      "sudo yum-config-manager --enable epel",
      "sudo yum install daemonize -y",
      "sudo yum install jenkins -y",
      "sudo service jenkins start",

      "sudo yum install nginx -y",
      "sudo service nginx start"
    ]
  }
}

# OUTPUT
output "aws_instance_public_dns" {
  value = aws_instance.nginx.public_dns
}

