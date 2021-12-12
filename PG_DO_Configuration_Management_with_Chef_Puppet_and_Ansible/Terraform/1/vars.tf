variable "myvar" {
 type = string
 default = "Hello from Bahman"

}

variable "mymap"{
 type = map
 default = {
   mykey = "my key value"
 }

}

variable "mylist" {
  type = list
  default = [1,2,3]
}
