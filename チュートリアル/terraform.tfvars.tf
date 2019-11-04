variable "region" {
  default = "ap-northeast-1"
}

variable "cidrs" { default = [] }
variable "cidrs" { type = list }
cidrs = [ "10.0.0.0/16", "10.1.0.0/16" ]

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}
