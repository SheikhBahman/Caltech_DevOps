variable "AWS_ACCESS_KEY" {
  default = "ASIASSZ2TSRJCUD35L4E"
}

variable "AWS_SECRET_KEY" {
  default = "UH2LfVft3h5/e79PRqjPXD9o2aA38XYSowDu/n+x"
}

variable "AWS_TOKEN" {
  default = "FwoGZXIvYXdzEEUaDPX2guNoGH/Nbr5eKSLAAeG5LaCauh7930iAw/GolPX/81h6uE9C0AKmHR0A9/hA5sQYYa9WXnimunKH5dC2e9S"
}

variable "AWS_REGION"{
  default = "us-east-1"
}

variable "AMIS"{

  type = map(string)
  default = {
    us-east-1 = "ami-083654bd07b5da81d"
    us-west-1 = "ami-"
    us-east-2 = "ami-"
  }
}

variable "PATH_TO_PRIVATE_KEY"{
  default = "newpem.pem"
}

variable "INSTANCE_USERNAME"{
  default = "ubuntu"
}
