variable "AWS_ACCESS_KEY" {
}
variable "AWS_SECRET_KEY" {
}
variable "AWS_TOKEN" {
}
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {

  type = map(string)
  default = {
    us-east-1 = "ami-083654bd07b5da81d"
    us-west-1 = "ami-"
    eu-east-1 = "ami-"
  }
}
