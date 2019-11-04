variable "region" {
  default = "ap-northeast-1"
}

variable "region" {
  default = "ap-northeast-1"
}

variable "cidrs" { default = [] }
variable "cidrs" { type = list }
cidrs = [ "10.0.0.0/16", "10.1.0.0/16" ]

variable "amis" {
  type = "map"
  default = {
    "ap-northeast-1” = "ami-0064e711cbc7a825e"
    "us-west-2" = "ami-4b32be2b"
  }
}