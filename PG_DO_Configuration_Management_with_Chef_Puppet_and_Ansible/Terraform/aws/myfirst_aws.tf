provider "aws" {
 access_key = var.AWS_ACCESS_KEY
 secret_key = var.AWS_SECRET_KEY
 token = var.AWS_TOKEN
 region = var.AWS_REGION
}

resource "aws_instance" "example" {
 ami = "ami-083654bd07b5da81d"
 instance_type = "t2.micro"
}
